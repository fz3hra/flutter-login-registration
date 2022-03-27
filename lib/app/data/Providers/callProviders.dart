import 'package:flutter/cupertino.dart';
import 'package:flutter_login/app/data/Providers/providers.dart';
import 'package:provider/provider.dart';

class CallUserProvider extends StatefulWidget {
  const CallUserProvider({Key? key}) : super(key: key);

  @override
  State<CallUserProvider> createState() => _CallUserProviderState();
}

class _CallUserProviderState extends State<CallUserProvider> {
  @override
  void initState(){
    super.initState();
    addData();
  }
  void addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
