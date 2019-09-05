package com.buba.utils;

import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class MultipartFileUtil {

    private static final  String URL="/Users/jia/Downloads/img/";
    private  static final   String JPG =".jpg";
    //使用当前时间做图片的前缀名
    private static SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
    public   static List<String> getMultipartFileUtil(MultipartFile[] filesName, String urlName){
        List<String> list= new ArrayList<>();
         if(filesName.length>0 && filesName!=null) {
             //遍历file数组
             for (int i = 0; i < filesName.length; i++) {
                 //format==20191614162503
                 String format = simpleDateFormat.format(new Date()) + "_" + i;
                 //存储的本地路径
                 File file = new File(URL + urlName + File.separator + format + JPG);
                 try {
                     if(!filesName[i].isEmpty()){
                         filesName[i].transferTo(file);
                         list.add(format);
                     }
                 } catch (IOException e) {
                     e.printStackTrace();
                 }
             }
         }
         return list;
     };

}
