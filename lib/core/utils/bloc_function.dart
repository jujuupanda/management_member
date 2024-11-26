part of 'utils.dart';

class BlocFunction {
  //get user profile data
  getProfile(BuildContext context) {
    context.read<ProfileBloc>().add(GetProfile());
  }

  logoutButton(BuildContext context) {
    return () {
      context.read<AuthBloc>().add(LogoutEvent());
    };
  }

  checkInButton(
    BuildContext context,
    String attendType,
    String imagePath,
    String location,
  ) {
    context.read<AttendanceBloc>().add(CheckInEvent(
          attendType,
          imagePath,
          location,
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
            ),
          ),
        );
  }

  getNews(BuildContext context) {
    context.read<NewsBloc>().add(GetNews());
  }

  initialProfile(BuildContext context) {
    context.read<ProfileBloc>().add(InitialProfile());
  }
}
