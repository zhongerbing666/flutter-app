import './home.dart';
import './secondary.dart';
class Routes{
    static final home = new VerseList();
    static final secondary = new SecondaryWidget();
    final routes = {
        '/': (context) => home,
        '/home': (context) => home,
        "/secondary": (context) => secondary
    };
}