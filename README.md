# uptask

A task management app for gig workers that allows users to create tasks and manage them.

### Architecture

```
📂 lib
 ┣ 📂 core
 ┃ ┣ 📂 constants
 ┃ ┣ 📂 routes
 ┃ ┣ 📂 theme
 ┃ ┣ 📜 service_locator.dart
 ┣ 📂 features
 ┃ ┣ 📂 task (example)
 ┃ ┃ ┣ 📂 data
 ┃ ┃ ┃ ┣ 📂 datasources
 ┃ ┃ ┃ ┃ ┣ 📜 task_local_datasource.dart
 ┃ ┃ ┃ ┃ ┣ 📜 task_remote_datasource.dart
 ┃ ┃ ┃ ┣ 📂 models
 ┃ ┃ ┃ ┃ ┣ 📜 task_model.dart
 ┃ ┃ ┃ ┣ 📂 repositories
 ┃ ┃ ┃ ┃ ┣ 📜 task_repository_impl.dart
 ┃ ┃ ┣ 📂 domain
 ┃ ┃ ┃ ┣ 📂 entities
 ┃ ┃ ┃ ┃ ┣ 📜 task_entity.dart
 ┃ ┃ ┃ ┣ 📂 repositories
 ┃ ┃ ┃ ┃ ┣ 📜 task_repository.dart
 ┃ ┃ ┃ ┣ 📂 usecases
 ┃ ┃ ┃ ┃ ┣ 📜 create_task.dart
 ┃ ┃ ┃ ┃ ┣ 📜 update_task.dart
 ┃ ┃ ┃ ┃ ┣ 📜 delete_task.dart
 ┃ ┃ ┃ ┃ ┣ 📜 get_tasks.dart
 ┃ ┃ ┣ 📂 presentation
 ┃ ┃ ┃ ┣ 📂 bloc
 ┃ ┃ ┃ ┃ ┣ 📜 task_bloc.dart
 ┃ ┃ ┃ ┃ ┣ 📜 task_event.dart
 ┃ ┃ ┃ ┃ ┣ 📜 task_state.dart
 ┃ ┃ ┃ ┣ 📂 pages
 ┃ ┃ ┃ ┃ ┣ 📜 task_list_page.dart
 ┃ ┃ ┃ ┃ ┣ 📜 task_form_page.dart
 ┃ ┃ ┃ ┣ 📂 widgets
 ┃ ┃ ┃ ┃ ┣ 📜 task_item.dart
 ┃ ┃ ┃ ┃ ┣ 📜 task_filter.dart
```

### Todo

- [x] implement authentication
- [ ] create task home page with bottom navigation and link task list and task calendar
- [ ] add services to create user specific tasks
- [ ] add task calendar
