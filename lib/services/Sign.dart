import 'package:crypto/crypto.dart';
import 'dart:convert';
class Sign{


    static getSign(json){
        List attrKeys=json.keys.toList();
        attrKeys.sort(); //排序  ASCII 字符顺序进行升序排列
        print(attrKeys);
        String str='';
        for(var i=0;i<attrKeys.length;i++){
            str+="${attrKeys[i]}${json[attrKeys[i]]}";
        }
        return md5.convert(utf8.encode(str)).toString();
    }
}