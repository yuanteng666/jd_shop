import 'dart:convert';
import 'package:jd_shop/utils/Storage.dart';


class UserInfoSerive {
    static getUserInfo () async{
        List userinfo ;
        try{
           var userinfoData =  json.decode(await Storage.getString('userinfo'));
           userinfo = userinfoData;
        }catch(e){
            userinfo = [];
        }
        return userinfo;
    }

    static getUserInfoState() async{
        List userinfo = await UserInfoSerive.getUserInfo();
        if(userinfo.length > 0){
            return true;
        }else{
            return false;
        }
    }

    static loginOut() async{
        await Storage.remove('userinfo');
    }
}