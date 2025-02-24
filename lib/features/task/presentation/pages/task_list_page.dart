import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uptask/features/task/domain/entities/task_entity.dart';
import 'package:uptask/features/task/presentation/bloc/task_bloc.dart';
import 'package:uptask/features/task/presentation/bloc/task_state.dart';
import 'package:uptask/features/task/presentation/widgets/task_create_bottom_sheet.dart';
import 'package:uptask/features/task/presentation/widgets/task_item.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  ScrollController _scrollController = ScrollController();
  String _selectedFilter = 'All';

  bool _appBarCollapsed = false;

  void _selectFilter(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  void _showTaskCreateBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => const TaskCreateBottomSheet(),
    );
  }

  bool get _isAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset > (120.h - kToolbarHeight);
  }

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() => _isAppBarExpanded
          ? setState(() {
              _appBarCollapsed = true;
            })
          : setState(() {
              _appBarCollapsed = false;
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: _appBarCollapsed ? 10.sp : 40.sp),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              expandedHeight: Platform.isAndroid ? 80.h : 120.h,
              collapsedHeight: Platform.isAndroid ? 58.h : 70.h,
              floating: false,
              surfaceTintColor: Colors.white,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: _buildFilterOptions(),
                background: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            padding: EdgeInsets.all(5.sp),
                            child: Icon(
                              CupertinoIcons.list_bullet_indent,
                              color: Colors.white,
                              size: 28.sp,
                            ),
                          ),
                          8.horizontalSpace,
                          Text(
                            'Tasks',
                            style: GoogleFonts.fredoka(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return BlocBuilder<TaskBloc, TaskState>(
                    builder: (context, state) {
                      if (state is TaskLoaded || state is TaskLoadingWithData) {
                        final tasks = state is TaskLoaded
                            ? state.tasks
                            : (state as TaskLoadingWithData).tasks;

                        final filteredTasks = _filterTasks(tasks);
                        final groupedTasks = _groupTasksByDate(filteredTasks);

                        return Column(
                          children: [
                            if (state is! TaskLoaded &&
                                (state is TaskLoaded ||
                                    state is TaskLoadingWithData))
                              LinearProgressIndicator(),
                            if (state is TaskLoaded && tasks.isNotEmpty ||
                                state is TaskLoadingWithData)
                              Column(
                                children:
                                    _getSortedKeys(groupedTasks).map((key) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4.sp, horizontal: 16.0),
                                        child: Text(
                                          key,
                                          style: GoogleFonts.fredoka(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      ...groupedTasks[key]!.map(
                                        (task) => TaskItem(task: task),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            if (state is TaskLoaded && tasks.isEmpty)
                              _emptyTaskList(),
                          ],
                        );
                      } else if (state is TaskFailure) {
                        return Center(child: Text(state.error));
                      }
                      return _emptyTaskList();
                    },
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoaded && state.tasks.isNotEmpty) {
            return FloatingActionButton(
              onPressed: () => _showTaskCreateBottomSheet(context),
              child: Icon(
                CupertinoIcons.plus,
                size: 25.sp,
                color: Colors.white,
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  Widget _emptyTaskList() {
    return Center(
      child: InkWell(
        onTap: () => _showTaskCreateBottomSheet(context),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Start Creating Tasks',
              style: GoogleFonts.fredoka(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
              ),
            ),
            10.horizontalSpace,
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 143, 124, 237),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterOptions() {
    return BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
      if (state is TaskLoaded || state is TaskLoadingWithData) {
        final tasks = state is TaskLoaded
            ? state.tasks
            : (state as TaskLoadingWithData).tasks;
        return Padding(
          padding: const EdgeInsets.only(
            left: 6.0,
          ),
          child: SizedBox(
            height: _appBarCollapsed ? 60.h : 50.h,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                _buildFilterTile('All', tasks.length),
                _buildFilterTile('Completed',
                    tasks.where((task) => task.isCompleted).length),
                _buildFilterTile('Low',
                    tasks.where((task) => task.priority == 'Low').length),
                _buildFilterTile('Medium',
                    tasks.where((task) => task.priority == 'Medium').length),
                _buildFilterTile('High',
                    tasks.where((task) => task.priority == 'High').length),
              ],
            ),
          ),
        );
      }
      return SizedBox.shrink();
    });
  }

  List<TaskEntity> _filterTasks(List<TaskEntity> tasks) {
    switch (_selectedFilter) {
      case 'All':
        return tasks;
      case 'Completed':
        return tasks.where((task) => task.isCompleted).toList();
      case 'Low':
        return tasks.where((task) => task.priority == 'Low').toList();
      case 'Medium':
        return tasks.where((task) => task.priority == 'Medium').toList();
      case 'High':
        return tasks.where((task) => task.priority == 'High').toList();
      default:
        return tasks;
    }
  }

  Map<String, List<TaskEntity>> _groupTasksByDate(List<TaskEntity> tasks) {
    final Map<String, List<TaskEntity>> groupedTasks = {};

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final yesterday = today.subtract(const Duration(days: 1));

    for (var task in tasks) {
      final taskDate =
          DateTime(task.dueDate.year, task.dueDate.month, task.dueDate.day);

      String category;
      if (taskDate == today) {
        category = 'Today';
      } else if (taskDate == tomorrow) {
        category = 'Tomorrow';
      } else if (taskDate == yesterday) {
        category = 'Yesterday';
      } else {
        category = DateFormat('EEEE').format(taskDate);
      }

      groupedTasks.putIfAbsent(category, () => []).add(task);
    }

    return groupedTasks;
  }

  List<String> _getSortedKeys(Map<String, List<TaskEntity>> groupedTasks) {
    List<String> keys = groupedTasks.keys.toList();

    keys.sort((a, b) {
      if (a == 'Today') return -1;
      if (b == 'Today') return 1;
      if (a == 'Tomorrow') return -1;
      if (b == 'Tomorrow') return 1;
      if (a == 'Yesterday') return 1;
      if (b == 'Yesterday') return -1;
      return 0;
    });

    return keys;
  }

  Widget _buildFilterTile(String filter, int? tasks) {
    bool isSelected = _selectedFilter == filter;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.sp),
      child: InkWell(
        onTap: () => _selectFilter(filter),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.white,
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(35.sp),
          ),
          margin: EdgeInsets.symmetric(horizontal: 2.sp),
          padding: EdgeInsets.symmetric(
            horizontal: 10.sp,
            vertical: 5.sp,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                filter,
                textAlign: TextAlign.center,
                style: GoogleFonts.fredoka(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
              if (tasks != null)
                _appBarCollapsed
                    ? Row(
                        children: [
                          10.horizontalSpace,
                          Container(
                            width: 30.w,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.green
                                  : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(15.sp),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              tasks.toString(),
                              style: GoogleFonts.fredoka(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
