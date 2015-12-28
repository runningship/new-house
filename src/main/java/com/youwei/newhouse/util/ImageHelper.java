package com.youwei.newhouse.util;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.awt.image.ConvolveOp;
import java.awt.image.Kernel;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.swing.ImageIcon;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

import sun.awt.image.codec.JPEGParam;

import com.sun.image.codec.jpeg.JPEGEncodeParam;

public class ImageHelper {

	public static void resize(String srcFile , int w, int h ,String destFile , float quality) throws IOException {  
        try {
        	
        	BufferedImage img = javax.imageio.ImageIO.read(new File(srcFile));
        	float rate = 270f/img.getWidth();
        	if(w==0){
        		w = img.getWidth();
        	}else{
        		w = (int) (img.getWidth() *rate);
        	}
        	if(h==0){
        		h = img.getHeight();
        	}else{
        		h = (int)(img.getHeight() *rate);
        	}
            BufferedImage _image = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);
            _image.getGraphics().drawImage(img, 0, 0, w, h, null); // 绘制缩小后的图  
            FileOutputStream newimageout = new FileOutputStream(destFile); // 输出到文件流  
            /* 
             * JPEGImageEncoder 将图像缓冲数据编码为 JPEG 数据流。该接口的用户应在 Raster 或 
             * BufferedImage 中提供图像数据，在 JPEGEncodeParams 对象中设置必要的参数， 并成功地打开 
             * OutputStream（编码 JPEG 流的目的流）。JPEGImageEncoder 接口可 将图像数据编码为互换的缩略 
             * JPEG 数据流，该数据流将写入提供给编码器的 OutputStream 中。 
             * 注意：com.sun.image.codec.jpeg 包中的类并不属于核心 Java API。它们属于 Sun 发布的 JDK 
             * 和 JRE 产品的组成部分。虽然其它获得许可方可能选择发布这些类，但开发人员不能寄 希望于从非 Sun 
             * 实现的软件中得到它们。我们期望相同的功能最终可以在核心 API 或标准扩 展中得到。 
             */  
            JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(newimageout);
            JPEGEncodeParam param = encoder.getDefaultJPEGEncodeParam(_image); 
            param.setQuality(quality,true);  
            encoder.setJPEGEncodeParam(param); 
            encoder.encode(_image); // 近JPEG编码  
            newimageout.close();  
        } catch (Exception ex) {  
            ex.printStackTrace();  
        }  
    }
	
}
