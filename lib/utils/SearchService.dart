
import 'Storage.dart';
import 'dart:convert';


class SearchService{
    static void saveData(value) async{
        try{
            List searchList = json.decode(await Storage.getString('searchList'));
            print(searchList);
            //判断是否存在
            bool isExsit = searchList.any((val){
                return val == value;
            });
            //不存在保存
            if(!isExsit){
                searchList.add(value);
                await Storage.setString('searchList', json.encode(searchList));
            }
        }catch(e){
            //第一次存储，没有数据，会报异常，所以这样处理
            List<String> list = List<String>();
            list.add(value);
            //保存数据
            await Storage.setString('searchList', json.encode(list));
        }
    }
}