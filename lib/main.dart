// @dart=2.9
import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:win_money_game/modules/Splash%20Screen/splash_screen.dart';
import 'package:win_money_game/modules/xo-online/components/createroom_screen.dart';
import 'package:win_money_game/modules/xo-online/components/createroom_screen_4_4.dart';
import 'package:win_money_game/modules/xo-online/components/createroom_screen_5_5.dart';
import 'package:win_money_game/modules/xo-online/components/join_room_screen.dart';
import 'package:win_money_game/modules/xo-online/components/join_room_screen_4_4.dart';
import 'package:win_money_game/modules/xo-online/components/join_room_screen_5_5.dart';
import 'package:win_money_game/modules/xo-online/first_xo_online_screen.dart';
import 'package:win_money_game/modules/xo-online/second_xo_online_screen.dart';
import 'package:win_money_game/modules/xo-online/third_xo_online_screen.dart';
import 'package:win_money_game/modules/xo-online/xo_create_or_join_xo_screen.dart';
import 'package:win_money_game/providers/room_data_provider.dart';
import 'package:win_money_game/providers/room_data_provider_4_4.dart';
import 'package:win_money_game/providers/room_data_provider_5_5.dart';
import 'package:win_money_game/providers/users_provider.dart';
import 'providers/sign_in_provider.dart';
//
// void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //
// //   await Firebase.initializeApp();
// //
// //   //ads
// //   Admob.initialize();
// //
// //   runApp(MultiProvider(
// //     providers: [
// //       ChangeNotifierProvider(create: (context)=>SignInProvider()),
// //       ChangeNotifierProvider(create: (context)=>UsersProvider()),
// //       ChangeNotifierProvider(create: (context)=>RoomDataProvider()),
// //       ChangeNotifierProvider(create: (context)=>RoomDataProviderFour()),
// //       ChangeNotifierProvider(create: (context)=>RoomDataProviderFive()),
// //     ],
// //     child: const MyApp(),
// //   ),);
// // }
// //
// // class MyApp extends StatelessWidget {
// //   const MyApp({Key key}) : super(key: key);
// //
// //   // This widget is the root of your application.
// //   @override
// //
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       // initialRoute: '/xo',
// //        initialRoute: '/',
// //       routes: {
// //         '/' : (context) => const SplashScreen(),
// //         '/second' : (context) => LoginScreen(),
// //         '/third' : (context) => const SelectPathScreen(),
// //         '/xo' : (context) => CreateOrJoinXOScreen(),
// //         '/createRoom' : (context) => CreateRoomScreen(),
// //         '/createRoom2' : (context) => CreateRoomScreen2(),
// //         '/createRoom3' : (context) => CreateRoomScreen3(),
// //         '/joinroom' : (context) => JoinRoomScreen(),
// //         '/joinroom2' : (context) => JoinRoomScreen2(),
// //         '/joinroom3' : (context) => JoinRoomScreen3(),
// //         '/game' : (context) => FirstXOOnlineScreen(),
// //         '/game2' : (context) => SecondXOOnlineScreen(),
// //         '/game3' : (context) => ThirdXOOnlineScreen(),
// //         // '/chess' : (context) => chessGame(),
// //       },
// //       supportedLocales: const [
// //         Locale('en', 'US')
// //       ],
// //       debugShowCheckedModeBanner: false,
// //       title: 'Win Money',
// //       theme: ThemeData(
// //         primarySwatch: Colors.deepPurple,
// //       ),
// //
// //     );
// //   }
// // }



import 'dart:math';

import 'package:win_money_game/modules/chess/chess_board/flutter_chess_board.dart';
import 'package:win_money_game/modules/chess/chess_board/src/chess_sub.dart' as chess_sub;
import 'package:win_money_game/modules/chess/generated/i18n.dart';
import 'package:win_money_game/modules/chess/util/online_game_utils.dart';
import 'package:win_money_game/modules/chess/util/utils.dart';
import 'package:win_money_game/modules/chess/util/widget_utils.dart';
import 'package:win_money_game/modules/chess/widgets/divider.dart';
import 'package:win_money_game/modules/chess/widgets/fancy_button.dart';
import 'package:win_money_game/modules/chess/widgets/fancy_options.dart';
import 'package:win_money_game/modules/chess/widgets/modal_progress_hud.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import 'package:win_money_game/modules/chess/chess_board/chess.dart';
import 'package:win_money_game/modules/chess/chess_board/src/chess_board.dart';
import 'package:win_money_game/modules/chess/chess_control/chess_controller.dart';

S strings;
ChessController _chessController;
OnlineGameController _onlineGameController;
SharedPreferences prefs;
String uuid;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp();

  //ads
  Admob.initialize();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context)=>SignInProvider()),
      ChangeNotifierProvider(create: (context)=>UsersProvider()),
      ChangeNotifierProvider(create: (context)=>RoomDataProvider()),
      ChangeNotifierProvider(create: (context)=>RoomDataProviderFour()),
      ChangeNotifierProvider(create: (context)=>RoomDataProviderFive()),
    ],
    child: const MyApp(),
  ),);
  Firebase.initializeApp();
  //add all licenses
  addLicenses();
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return MaterialApp(

      // initialRoute: '/xo',
       initialRoute: '/',
      routes: {
        '/' : (context) => const SplashScreen(),
        '/xo' : (context) => CreateOrJoinXOScreen(),
        '/createRoom' : (context) => CreateRoomScreen(),
        '/createRoom2' : (context) => CreateRoomScreen2(),
        '/createRoom3' : (context) => CreateRoomScreen3(),
        '/joinroom' : (context) => JoinRoomScreen(),
        '/joinroom2' : (context) => JoinRoomScreen2(),
        '/joinroom3' : (context) => JoinRoomScreen3(),
        '/game' : (context) => FirstXOOnlineScreen(),
        '/game2' : (context) => SecondXOOnlineScreen(),
        '/game3' : (context) => ThirdXOOnlineScreen(),
        '/chess' : (context) => chessGame(),

      },
      supportedLocales: const [
        Locale('en', 'US'),

      ],
      debugShowCheckedModeBanner: false,
      title: 'Win Money',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),

    );
  }
}

class chessGame extends StatefulWidget {
  chessGame({Key key}) : super(key: key);

  @override
  _chessGameState createState() => _chessGameState();
}

class _chessGameState extends State<chessGame> {
  Future<void> _loadEverythingUp() async {
    //load the old game
    await _chessController.loadOldGame();
    //set the king in chess board
    _chessController.setKingInCheckSquare();
    //await prefs
    prefs = await SharedPreferences.getInstance();
    //load values from prefs
    //the chess controller has already been set here!
    _chessController.botColor =
        chess_sub.Color.fromInt(prefs.getInt('bot_color') ?? 1);
    _chessController.whiteSideTowardsUser =
        prefs.getBool('whiteSideTowardsUser') ?? true;
    _chessController.botBattle = prefs.getBool('botbattle') ?? false;
    //load user id and if not available create and save one
    uuid = prefs.getString('uuid');
    if (uuid == null) {
      uuid = Uuid().v4();
      prefs.setString('uuid', uuid);
    }
  }

  @override
  Widget build(BuildContext context) {
    //set strings object
    strings ??= S.of(context);
    //init the context singleton object
    ContextSingleton(context);
    //build the chess controller,
    //if needed set context newly
    if (_chessController == null)
      _chessController = ChessController(context);
    else
      _chessController.context = context;
    //create the online game controller if is null
    _onlineGameController ??= OnlineGameController(_chessController);
    //future builder: load old screen and show here on start the loading screen,
    //when the future is finished,
    //with setState show the real scaffold
    //return the view
    return (_chessController.game == null)
        ? FutureBuilder(
      future: _loadEverythingUp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            var error = snapshot.error;
            print('$error');
            return Center(child: Text(strings.error));
          }

          return MyHomePageAfterLoading();
        } else {
          return Center(
              child: ModalProgressHUD(
                child: Container(),
                inAsyncCall: true,
              ));
        }
      },
    )
        : MyHomePageAfterLoading();
  }
}

class MyHomePageAfterLoading extends StatefulWidget {
  MyHomePageAfterLoading({Key key}) : super(key: key);

  @override
  _MyHomePageAfterLoadingState createState() => _MyHomePageAfterLoadingState();
}

class _MyHomePageAfterLoadingState extends State<MyHomePageAfterLoading>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        _chessController.saveOldGame();
        break;
      default:
        break;
    }
  }

  void update() {
    setState(() {});
  }

  Future<bool> _onWillPop() async {
    _chessController.saveOldGame();
    return true;
  }

  void _onAbout() async {
    //show the about dialog
    showAboutDialog(
      context: context,
      applicationVersion: version,
      applicationIcon: Image.asset(
        'res/drawable/ic_launcher.png',
        width: 50,
        height: 50,
      ),
      applicationLegalese: await rootBundle.loadString('res/licenses/this'),
      children: [
        FancyButton(
          onPressed: () => launch(strings.privacy_url),
          text: strings.privacy_title,
        )
      ],
    );
  }

  void _onWarning() {
    showAnimatedDialog(
        title: strings.warning,
        forceCancelText: 'no',
        onDoneText: 'yes',
        icon: Icons.warning,
        onDone: (value) {},
        children: [Image.asset('res/drawable/moo.png')]);
  }

  void _onJoinCode() {
    //dialog to enter a code
    showAnimatedDialog(
        title: strings.enter_game_id,
        onDoneText: strings.join,
        icon: Icons.transit_enterexit,
        withInputField: true,
        inputFieldHint: strings.game_id_ex,
        onDone: (value) {
          _onlineGameController.joinGame(value);
        });
  }

  void _onCreateCode() {
    //if is currently in a game, this will disconnect from all local games, reset the board and create a firestore document
    showAnimatedDialog(
      title: strings.warning,
      text: strings.game_reset_join_code_warning,
      onDoneText: strings.proceed,
      icon: Icons.warning,
      onDone: (value) {
        if (value == 'ok') _onlineGameController.finallyCreateGameCode();
      },
    );
  }

  void _onLeaveOnlineGame() {
    //show dialog to leave the online game
    showAnimatedDialog(
      title: strings.leave_online_game,
      text: strings.deleting_as_host_info,
      icon: Icons.warning,
      onDoneText: strings.ok,
      onDone: (value) {
        if (value == 'ok') _onlineGameController.leaveGame();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //get the available height for the chess board
    double availableHeight = MediaQuery.of(context).size.height - 184.3;
    //set the update method
    _chessController.update = update;
    //set the update method in the online game controller
    _onlineGameController.update = update;
    //the default scaffold
    return WillPopScope(
      onWillPop: _onWillPop,
      child: ModalProgressHUD(
        inAsyncCall: ChessController.loadingBotMoves,
        progressIndicator: kIsWeb
            ? Text(
          strings.loading_moves_web,
          style: Theme.of(context).textTheme.subtitle2,
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // children: [
          //   CircularProgressIndicator(),
          //   Text(
          //     // strings.moves_done(_chessController.progress),
          //     style: Theme.of(context).textTheme.bodyText1,
          //   ),
          // ],
        ),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.brown[50],
            body: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Visibility(
                              visible: !inOnlineGame,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // FlatButton(
                                  //   shape: roundButtonShape,
                                  //   onPressed: () {
                                  //     //inverse the bot color and save it
                                  //     _chessController.botColor =
                                  //         chess_sub.Color.flip(
                                  //             _chessController.botColor);
                                  //     //save value int to prefs
                                  //     prefs.setInt('bot_color',
                                  //         _chessController.botColor.value);
                                  //     //set state, update the views
                                  //     setState(() {});
                                  //     //make move if needed
                                  //     _chessController.makeBotMoveIfRequired();
                                  //   },
                                  //   child: Text(
                                  //       (_chessController.botColor ==
                                  //               chess_sub.Color.WHITE)
                                  //           ? strings.white
                                  //           : strings.black,
                                  //       style:
                                  //           Theme.of(context).textTheme.button),
                                  // ),
                                  // SizedBox(
                                  //   width: 8,
                                  // ),
                                  AbsorbPointer(
                                    child:LiteRollingSwitch(
                                      value: (prefs?.getBool("bot") ?? true),
                                      onChanged: (pos) {
                                        prefs.setBool("bot", true);
                                        //make move if needed
                                        _chessController?.makeBotMoveIfRequired();
                                      },
                                      iconOn: Icons.done,
                                      iconOff: Icons.close,
                                      // textOff: strings.bot_off,
                                      // textOn: strings.bot_on,
                                      colorOff: Colors.red[800],
                                      colorOn: Colors.green[800],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(8),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       SelectableText(
                          //         currentGameCode,
                          //         style: Theme.of(context).textTheme.subtitle2,
                          //       ),
                          //       Text(
                          //           strings.turn_of_x(
                          //               (_chessController?.game?.game?.turn ==
                          //                       chess_sub.Color.BLACK)
                          //                   ? strings.black
                          //                   : strings.white),
                          //           style: Theme.of(context)
                          //               .textTheme
                          //               .subtitle1
                          //               .copyWith(
                          //                 inherit: true,
                          //                 color: (_chessController?.game
                          //                             ?.in_check() ??
                          //                         false)
                          //                     ? ((_chessController.game
                          //                             .inCheckmate(
                          //                                 _chessController.game
                          //                                     .moveCountIsZero()))
                          //                         ? Colors.purple
                          //                         : Colors.red)
                          //                     : Colors.black,
                          //               )),
                          //     ],
                          //   ),
                          // ),
                          Center(
                            // Center is a layout widget. It takes a single child and positions it
                            // in the middle of the parent.
                            child: SafeArea(
                              child: ChessBoard(
                                boardType: boardTypeFromString(
                                    prefs.getString('board_style') ?? 'o'),
                                size: min(MediaQuery.of(context).size.width,
                                    availableHeight),
                                onCheckMate: _chessController.onCheckMate,
                                onDraw: _chessController.onDraw,
                                onMove: _chessController.onMove,
                                onCheck: _chessController.onCheck,
                                chessBoardController:
                                _chessController.controller,
                                chess: _chessController.game,
                                whiteSideTowardsUser:
                                _chessController.whiteSideTowardsUser,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    collapseFancyOptions = true;
                    setState(() {});
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  FancyOptions(
                                    up: true,
                                    rootIcon: Icons.online_prediction,
                                    // rootText: strings.online_game_options,
                                    children: [
                                      // FancyButton(
                                      //   onPressed: _onJoinCode,
                                      //   text: strings.join_code ?? "",
                                      //   icon: Icons.transit_enterexit,
                                      //   animation: FancyButtonAnimation.pulse,
                                      // ),
                                      // FancyButton(
                                      //   onPressed: _onCreateCode,
                                      //   text: strings.create_code,
                                      //   icon: Icons.add,
                                      //   animation: FancyButtonAnimation.pulse,
                                      // ),
                                      // FancyButton(
                                      //   text: strings.leave_online_game,
                                      //   animation: FancyButtonAnimation.pulse,
                                      //   icon: Icons.exit_to_app,
                                      //   visible: inOnlineGame,
                                      //   onPressed: _onLeaveOnlineGame,
                                      // ),
                                    ],
                                  ),
                                  // Divider8(),
                                  // FancyButton(
                                  //   visible: !inOnlineGame,
                                  //   onPressed: _chessController.undo,
                                  //   animation: FancyButtonAnimation.pulse,
                                  //   icon: Icons.undo,
                                  //   text: strings.undo,
                                  // ),
                                  // DividerIfOffline(),
                                  // FancyButton(
                                  //   visible: !inOnlineGame,
                                  //   onPressed: _chessController.resetBoard,
                                  //   icon: Icons.autorenew,
                                  //   text: strings.replay,
                                  // ),
                                  // DividerIfOffline(),
                                  // Divider8(),
                                  // FancyButton(
                                  //   visible: !inOnlineGame,
                                  //   onPressed: _chessController.switchColors,
                                  //   icon: Icons.switch_left,
                                  //   text: strings.switch_colors,
                                  // ),
                                  // DividerIfOffline(),
                                  // FancyButton(
                                  //   visible: !inOnlineGame,
                                  //   onPressed: _chessController.onSetDepth,
                                  //   icon: Icons.upload_rounded,
                                  //   animation: FancyButtonAnimation.pulse,
                                  //   text: strings.difficulty,
                                  // ),
                                  // DividerIfOffline(),
                                  // FancyButton(
                                  //   onPressed:
                                  //       _chessController.changeBoardStyle,
                                  //   icon: Icons.style,
                                  //   animation: FancyButtonAnimation.pulse,
                                  //   text: strings.choose_style,
                                  // ),
                                  // Divider8(),
                                  // FancyButton(
                                  //   visible: !inOnlineGame,
                                  //   onPressed: _chessController.onFen,
                                  //   text: 'fen',
                                  // ),
                                  // DividerIfOffline(),
                                  // Visibility(
                                  //   visible: !inOnlineGame,
                                  //   child: Container(
                                  //     width: 150,
                                  //     child: CheckboxListTile(
                                  //       shape: roundButtonShape,
                                  //       title: Text(strings.bot_vs_bot),
                                  //       value: _chessController.botBattle,
                                  //       onChanged: (value) {
                                  //         prefs.setBool('botbattle', value);
                                  //         _chessController.botBattle = value;
                                  //         setState(() {});
                                  //         //check if has to make bot move
                                  //         if (!_chessController
                                  //             .makeBotMoveIfRequired()) {
                                  //           //since move has not been made, inverse the bot color and retry
                                  //           _chessController.botColor =
                                  //               Chess.swap_color(
                                  //                   _chessController.botColor);
                                  //           _chessController
                                  //               .makeBotMoveIfRequired();
                                  //         }
                                  //       },
                                  //     ),
                                  //   ),
                                  // ),
                                  // DividerIfOffline(),
                                  // FancyOptions(
                                  //   up: true,
                                  //   rootIcon: Icons.devices,
                                  //   rootText:
                                  //       strings.availability_other_devices,
                                  //   // children: [
                                  //   //   FancyButton(
                                  //   //     onPressed: () =>
                                  //   //         launch(strings.playstore_url),
                                  //   //     text: strings.android,
                                  //   //     icon: Icons.android,
                                  //   //     animation: FancyButtonAnimation.pulse,
                                  //   //   ),
                                  //   //   // FancyButton(
                                  //   //   //   onPressed: () =>
                                  //   //   //       launch(strings.website_url),
                                  //   //   //   text: strings.web,
                                  //   //   //   icon: Icons.web,
                                  //   //   //   animation: FancyButtonAnimation.pulse,
                                  //   //   // ),
                                  //   // ],
                                  // ),
                                  // Divider8(),
                                  // FancyButton(
                                  //   onPressed: () =>
                                  //       (random.nextInt(80100) == 420)
                                  //           ? _onWarning()
                                  //           : _onAbout(),
                                  //   icon: Icons.info,
                                  //   animation: FancyButtonAnimation.pulse,
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
