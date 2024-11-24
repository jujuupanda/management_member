part of 'utils.dart';

class ImageLoader {
  CachedNetworkImage profileSquare(UserEntity dataUser) {
    return CachedNetworkImage(
      imageUrl: dataUser.image,
      fit: BoxFit.cover,
      imageBuilder: (context, imageProvider) {
        return Image.network(
          dataUser.image,
          fit: BoxFit.cover,
        );
      },
      placeholder: (context, url) {
        return const CustomCircleLoading();
      },
      errorWidget: (context, url, error) {
        return Image.asset(
          NamedString().noProfilePicture,
          fit: BoxFit.cover,
        );
      },
    );
  }

  CachedNetworkImage profileCircle(UserEntity dataUser) {
    return CachedNetworkImage(
      imageUrl: dataUser.image,
      fit: BoxFit.cover,
      imageBuilder: (context, imageProvider) {
        return CircleAvatar(
          backgroundImage: NetworkImage(
            dataUser.image,
          ),
        );
      },
      placeholder: (context, url) {
        return const CustomCircleLoading();
      },
      errorWidget: (context, url, error) {
        return CircleAvatar(
          backgroundImage: AssetImage(
            NamedString().noProfilePicture,
          ),
        );
      },
    );
  }

  CachedNetworkImage attendanceCircle(AttendanceEntity attendToday) {
    return CachedNetworkImage(
      imageUrl: attendToday.attendToday.photoUrl,
      fit: BoxFit.cover,
      imageBuilder: (context, imageProvider) {
        return CircleAvatar(
          backgroundImage: NetworkImage(
            attendToday.attendToday.photoUrl,
          ),
        );
      },
      placeholder: (context, url) {
        return const CustomCircleLoading();
      },
      errorWidget: (context, url, error) {
        return CircleAvatar(
          backgroundImage: AssetImage(
            NamedString().noProfilePicture,
          ),
        );
      },
    );
  }
}
