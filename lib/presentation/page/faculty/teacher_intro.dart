import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:teacher_search/const/data_status.dart';
import 'package:teacher_search/extension/context_extension.dart';
import 'package:teacher_search/presentation/page/error_page.dart';
import 'package:teacher_search/presentation/widget/leading_title.dart';
import 'package:teacher_search/state/prov_manager.dart';
import 'package:teacher_search/state/teacher_search_prov.dart';
import 'package:teacher_search/style/style_scheme.dart';


class TeacherIntro extends StatefulWidget{
  final String? teacherId;
  const TeacherIntro({super.key, this.teacherId});

  @override
  State<StatefulWidget> createState() => _TeacherIntroState();
}

class _TeacherIntroState extends State<TeacherIntro> with TickerProviderStateMixin{

  late final TabController _tabController;
  final tProv = ProvManager.teacherSearchProv;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stheme= ShadTheme.of(context);
    final mtheme= context.theme;
    return Material(
      child: Selector<TeacherSearchProv, DataStatus>(
        selector: (_, teacherSearchProv) => teacherSearchProv.nowTeacherStatus,
        shouldRebuild: (prev, next) => prev != next,
        builder: (__,status,_){
          switch(status){
            case DataStatus.initial:
            case DataStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case DataStatus.failure:
              return ErrorPage(
                onRetry: () => tProv.seeTeacherFromId(widget.teacherId!),
              );
            case DataStatus.success:
              return Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 15.w,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 8.w,),
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 35,
                                  maxHeight: 35,
                                ),
                                child: IconButton.outlined(
                                  color: context.theme.colorScheme.outline,
                                  icon: Icon(
                                    Icons.arrow_back,
                                    size: 18.sp,
                                  ),
                                  style: IconButton.styleFrom(
                                    side: BorderSide(
                                      color: context.theme.colorScheme.outlineVariant,
                                      width: 1,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: EdgeInsets.all(3.sp),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                              SizedBox(width: 15.w,),
                              Text(
                                'CSU Infomation Portal',
                                style: TextStyle(
                                  color: const Color(0xff005dad),
                                  fontSize: 20.sp,
                                  fontFamily: StyleScheme.engFontFamily,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                              child: ListView(
                                children: [
                                  SizedBox(height: 20.h,),
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: NetworkImage(tProv.nowTeacher!.picUrl),
                                            fit: BoxFit.cover,
                                          ),
                                          border: Border.all(
                                            color: context.theme.colorScheme.outlineVariant,
                                            width: 0.5,
                                          ),
                                        ),
                                        constraints: BoxConstraints(
                                          maxWidth: 140.w,
                                          maxHeight: 140.w,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h,),
                                  Text(
                                    tProv.nowTeacher!.teacherName,
                                    style: TextStyle(
                                      fontSize: 27.sp,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.5,
                                      fontFamily: StyleScheme.cnFontFamily,
                                    ),
                                  ),
                                  Text(
                                    tProv.nowTeacher!.title,
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      color: context.theme.colorScheme.secondary,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -0.5,
                                      fontFamily: StyleScheme.engFontFamily,
                                    ),
                                  ),
                                  SizedBox(height: 20.h,),
                                  LeadingTitle(
                                    title: 'Info Detail',
                                    fontSize: 20.sp,
                                    titleColor: context.theme.colorScheme.onSurface,
                                  ),
                                  SizedBox(height: 20.h,),
                                  GridView(
                                    shrinkWrap: true,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 0,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 6,
                                    ),
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            LucideIcons.school,
                                            color: context.theme.colorScheme.outline,
                                          ),
                                          SizedBox(width: 5.w,),
                                          Text(
                                            'School',
                                            style: context.theme.textTheme.titleMedium?.copyWith(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              color: context.theme.colorScheme.outline,
                                              fontFamily: StyleScheme.engFontFamily,
                                              letterSpacing: -0.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        tProv.nowTeacher!.schoolName,
                                        style: context.theme.textTheme.titleMedium?.copyWith(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: -0.5,
                                          wordSpacing: 1.5,
                                          fontFamily: StyleScheme.cnFontFamily,
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.account_balance_sharp,
                                            color: context.theme.colorScheme.outline,
                                          ),
                                          SizedBox(width: 5.w,),
                                          Text(
                                            'Major',
                                            style: context.theme.textTheme.titleMedium?.copyWith(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: -0.5,
                                              color: context.theme.colorScheme.outline,
                                              fontFamily: StyleScheme.engFontFamily,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        tProv.nowTeacher!.majorName,
                                        style: StyleScheme.cn_onSuf_500_LPN03(
                                          size: 15.sp,
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            LucideIcons.house,
                                            color: context.theme.colorScheme.outline,
                                          ),
                                          SizedBox(width: 5.w,),
                                          Text(
                                            '学历',
                                            style: context.theme.textTheme.titleMedium?.copyWith(
                                              fontSize: 15.sp,
                                              letterSpacing: -0.5,
                                              fontWeight: FontWeight.w500,
                                              color: context.theme.colorScheme.outline,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        tProv.nowTeacher!.bachelor,
                                        style: context.theme.textTheme.titleMedium?.copyWith(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            LucideIcons.timer,
                                            color: context.theme.colorScheme.outline,
                                          ),
                                          SizedBox(width: 5.w,),
                                          Text(
                                            'Email',
                                            style: context.theme.textTheme.titleMedium?.copyWith(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              color: context.theme.colorScheme.outline,
                                              fontFamily: StyleScheme.engFontFamily,
                                              letterSpacing: -0.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        tProv.nowTeacher!.email,
                                        style: context.theme.textTheme.titleMedium?.copyWith(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: -0.5,
                                          fontFamily: StyleScheme.engFontFamily,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20.h,),
                                  LeadingTitle(
                                    title: 'Address',
                                    fontSize: 20.sp,
                                    titleColor: context.theme.colorScheme.onSurface,
                                  ),
                                  SizedBox(height: 10.h,),
                                  Text(
                                    tProv.nowTeacher!.address,
                                    style: context.theme.textTheme.titleMedium?.copyWith(
                                      fontSize: 15.sp,
                                      color: context.theme.colorScheme.secondary,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -0.5,
                                      fontFamily: StyleScheme.engFontFamily,
                                    ),
                                  ),
                                  SizedBox(height: 20.h,),
                                  LeadingTitle(
                                    title: 'Research Focus',
                                    fontSize: 20.sp,
                                    titleColor: context.theme.colorScheme.onSurface,
                                  ),
                                  SizedBox(height: 10.h,),
                                  Text(
                                    tProv.nowTeacher!.researchFocus,
                                    style: context.theme.textTheme.titleMedium?.copyWith(
                                      fontSize: 15.sp,
                                      color: context.theme.colorScheme.secondary,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -0.5,
                                      fontFamily: StyleScheme.engFontFamily,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 15,
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.w, top: 10.h),
                      child: Container(
                        decoration: BoxDecoration(
                          color: context.theme.colorScheme.surface,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          border: Border.all(
                            color: context.theme.colorScheme.outlineVariant,
                            width: 0.5,
                          ),
                        ),
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(width: 15.w,),
                                  Text(
                                    'Detailed Information',
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -0.5,
                                      fontFamily: StyleScheme.engFontFamily,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: context.theme.colorScheme.outlineVariant,
                              thickness: 0.5,
                              height: 0.5.h,
                            ),
                            TabBar(
                              tabAlignment: TabAlignment.start,
                              isScrollable: true,
                              controller: _tabController,
                              indicatorPadding: const EdgeInsets.symmetric(vertical: 0),
                              indicatorColor: context.theme.colorScheme.onSurface,
                              unselectedLabelStyle: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: StyleScheme.engFontFamily,
                              ),
                              labelStyle: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: StyleScheme.engFontFamily,
                                color: context.theme.colorScheme.onSurface,
                              ),
                              unselectedLabelColor: context.theme.colorScheme.outline.withOpacity(0.9),
                              tabs: const [
                                Tab(
                                  text: 'Main',
                                ),
                                Tab(
                                  text: 'Research Papers',
                                ),
                                Tab(
                                  text: 'Publications',
                                ),
                                Tab(
                                  text: 'Patents',
                                ),
                              ],
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: MediaQuery.of(context).size.height-130.h,
                              ),
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  SingleChildScrollView(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          LeadingTitle(
                                            title: 'Teacher Description',
                                            fontSize: 20.sp,
                                            titleColor: context.theme.colorScheme.onSurface,
                                          ),
                                          SizedBox(height: 15.h,),
                                          Text(
                                            tProv.nowTeacher!.desc,
                                            style: context.theme.textTheme.titleMedium?.copyWith(
                                              fontSize: 15.sp,
                                              color: context.theme.colorScheme.secondary,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: -0.5,
                                              fontFamily: StyleScheme.cnFontFamily,
                                            ),
                                            strutStyle: const StrutStyle(
                                              height: 1.5,
                                            ),
                                          ),
                                          SizedBox(height: 25.h,),
                                          LeadingTitle(
                                            title: 'Education Experience',
                                            fontSize: 20.sp,
                                            titleColor: context.theme.colorScheme.onSurface,
                                          ),
                                          SizedBox(height: 15.h,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  CircleAvatar(
                                                    child: Icon(
                                                      LucideIcons.school,
                                                      color: context.theme.colorScheme.primary,
                                                    ),
                                                  ),
                                                  SizedBox(width: 20.w,),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Ph.D. in Computer Science',
                                                        style: context.theme.textTheme.titleMedium?.copyWith(
                                                          fontSize: 18.sp,
                                                          fontWeight: FontWeight.w500,
                                                          color: context.theme.colorScheme.onSurface,
                                                          fontFamily: StyleScheme.engFontFamily,
                                                          letterSpacing: -0.5,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Stanford University  |  2004.4 - 2005.6',
                                                            style: context.theme.textTheme.titleMedium?.copyWith(
                                                              fontSize: 16.sp,
                                                              fontWeight: FontWeight.w500,
                                                              color: context.theme.colorScheme.secondary,
                                                              fontFamily: StyleScheme.engFontFamily,
                                                              letterSpacing: -0.5,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  minHeight: 30.h,
                                                ),
                                                child: IntrinsicHeight(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 15.w),
                                                    child: VerticalDivider(
                                                      color: context.theme.colorScheme.outlineVariant,
                                                      thickness: 2,
                                                      width: 10,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  CircleAvatar(
                                                    child: Icon(
                                                      LucideIcons.school,
                                                      color: context.theme.colorScheme.primary,
                                                    ),
                                                  ),
                                                  SizedBox(width: 20.w,),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Ph.D. in Computer Science',
                                                        style: context.theme.textTheme.titleMedium?.copyWith(
                                                          fontSize: 18.sp,
                                                          fontWeight: FontWeight.w500,
                                                          color: context.theme.colorScheme.onSurface,
                                                          fontFamily: StyleScheme.engFontFamily,
                                                          letterSpacing: -0.5,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Stanford University  |  2004.4 - 2005.6',
                                                            style: context.theme.textTheme.titleMedium?.copyWith(
                                                              fontSize: 16.sp,
                                                              fontWeight: FontWeight.w500,
                                                              color: context.theme.colorScheme.secondary,
                                                              fontFamily: StyleScheme.engFontFamily,
                                                              letterSpacing: -0.5,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                                    child: ListView(
                                      children: [
                                        SizedBox(height: 20.h,),
                                        LeadingTitle(
                                          title: 'Research Papers',
                                          fontSize: 20.sp,
                                          titleColor: context.theme.colorScheme.onSurface,
                                        ),
                                        SizedBox(height: 15.h,),
                                        ...List.generate(20, (index) => Column(
                                          children: [
                                            ListTile(
                                              contentPadding: EdgeInsets.zero,
                                              title: Text(
                                                'A Novel Approach to Network Security',
                                                style: context.theme.textTheme.titleMedium?.copyWith(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: context.theme.colorScheme.onSurface,
                                                  fontFamily: StyleScheme.engFontFamily,
                                                  letterSpacing: -0.5,
                                                ),
                                              ),
                                              subtitle: Text(
                                                'IEEE Transactions on Network Security',
                                                style: context.theme.textTheme.titleMedium?.copyWith(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: context.theme.colorScheme.secondary,
                                                  fontFamily: StyleScheme.engFontFamily,
                                                  letterSpacing: -0.5,
                                                ),
                                              ),
                                              trailing: Text(
                                                '2021.6',
                                                style: context.theme.textTheme.titleMedium?.copyWith(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: context.theme.colorScheme.secondary,
                                                  fontFamily: StyleScheme.engFontFamily,
                                                  letterSpacing: -0.5,
                                                ),
                                              ),
                                            ),
                                            Divider(
                                              color: context.theme.colorScheme.outlineVariant,
                                              thickness: 0.5,
                                              height: 0.5.h,
                                            ),
                                          ],
                                        )),
                                      ],
                                    ),
                                  ),
                                  Text('Elective Course'),
                                  Text('Elective Course'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
          }
        },
      )
    );
  }
}