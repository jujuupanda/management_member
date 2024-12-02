part of 'utils.dart';

class BlocFunction {
  //Auth
  loginButton(
    BuildContext context,
    String username,
    String password,
  ) {
    BlocProvider.of<AuthBloc>(context).add(
      LoginEvent(
        LoginParam(
          username,
          password,
        ),
      ),
    );
  }

  logoutButton(BuildContext context) {
    return () {
      context.read<AuthBloc>().add(LogoutEvent());
    };
  }

  //Profile
  initialProfile(BuildContext context) {
    context.read<ProfileBloc>().add(InitialProfile());
  }

  getProfile(BuildContext context) {
    context.read<ProfileBloc>().add(GetProfile());
  }

  addUser(
    BuildContext context,
    String username,
    String password,
    String role,
    String fullName,
    String division,
    String phone,
    String activeWork,
  ) {
    context.read<ProfileBloc>().add(AddUser(
          username,
          password,
          role,
          fullName,
          division,
          phone,
          activeWork,
        ));
  }

  editProfile(
    BuildContext context,
    UserEntity user,
    Map<String, dynamic> object,
  ) {
    context.read<ProfileBloc>().add(EditProfile(user, object));
  }

  changePassword(
    BuildContext context,
    String oldPassword,
    String newPassword,
  ) {
    context.read<ProfileBloc>().add(ChangePassword(oldPassword, newPassword));
  }

  //Attendance
  checkInButton(
    BuildContext context,
    String attendType,
    File imageFile,
  ) {
    context.read<AttendanceBloc>().add(CheckInEvent(
          attendType,
          imageFile,
        ));
  }

  checkOutButton(BuildContext context) {
    context.read<AttendanceBloc>().add(CheckOutEvent());
  }

  attendChecker(BuildContext context) {
    context.read<AttendanceBloc>().add(AttendCheckerEvent());
  }

  getAttendance(BuildContext context) {
    context.read<AttendanceBloc>().add(GetAttendanceEvent());
  }

  //News
  createNews(
    BuildContext context,
    String title,
    String content,
    List<String> image,
    String category,
  ) {
    context.read<NewsBloc>().add(
          CreateNews(
            NewsModel(
              id: "",
              title: title,
              content: content,
              image: image,
              author: "",
              publishedAt: "",
              category: category,
              archived: false,
            ),
          ),
        );
  }

  getNews(BuildContext context) {
    context.read<NewsBloc>().add(GetNews());
  }

  editNews(BuildContext context, NewsEntity news, Map<String, dynamic> object) {
    context.read<NewsBloc>().add(EditNews(news, object));
  }

  deleteNews(BuildContext context, NewsEntity news) {
    context.read<NewsBloc>().add(DeleteNews(news));
  }

  //Manage Attendance
  getAllAttendanceAllAccount(BuildContext context) {
    context.read<ManageAttendanceBloc>().add(GetAllAttendanceAllAccount());
  }
}
