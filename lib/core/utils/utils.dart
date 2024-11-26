import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../features/attendance/domain/entities/attendance_entity.dart';
import '../../features/attendance/presentation/manager/attendance_bloc.dart';
import '../../features/login/presentation/manager/auth_bloc.dart';
import '../../features/news/data/models/news_model.dart';
import '../../features/news/domain/entities/news_entity.dart';
import '../../features/news/presentation/manager/news_bloc.dart';
import '../../features/profile/domain/entities/user_entity.dart';
import '../../features/profile/presentation/manager/profile_bloc.dart';
import '../routes/route_app.dart';
import '../services/database_service.dart';
import '../services/geo_location_service.dart';
import '../widgets/custom_circle_loading.dart';

part 'palette_color.dart';

part 'style_text.dart';

part 'bloc_function.dart';

part 'parsing_string.dart';

part 'pick_image.dart';

part 'pop_up_dialog.dart';

part 'sorting_filter_object.dart';

part 'named_string.dart';

part 'image_loader.dart';
