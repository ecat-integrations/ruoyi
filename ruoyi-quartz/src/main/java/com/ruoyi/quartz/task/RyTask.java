package com.ruoyi.quartz.task;

import com.ruoyi.quartz.domain.SysJob;
import com.ruoyi.quartz.service.ISysJobService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.ruoyi.common.utils.StringUtils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.List;
import java.util.concurrent.TimeUnit;
/**
 * 定时任务调度测试
 * 
 * @author ruoyi
 */
@Component("ryTask")
public class RyTask
{
    @Autowired
    private ISysJobService jobService;



    public void ryMultipleParams(String s, Boolean b, Long l, Double d, Integer i)
    {
        System.out.println(StringUtils.format("执行多参方法： 字符串类型{}，布尔类型{}，长整型{}，浮点型{}，整形{}", s, b, l, d, i));
    }

    public void ryParams(String params)
    {
        System.out.println("执行有参方法：" + params);
    }

    public void ryNoParams()
    {
        System.out.println("执行无参方法");
    }

    /**
     * 运行 Python 脚本
     * @param pythonPath Python 解释器路径
         * @param runPath Python 脚本路径
     */
    public void runPython(String pythonPath, String runPath)
    {
        try {
            // 构建运行命令
            ProcessBuilder processBuilder = new ProcessBuilder(pythonPath, runPath);
            processBuilder.redirectErrorStream(true); // 将错误输出流重定向到标准输出流

            // 启动进程
            Process process = processBuilder.start();

            // 读取输出
            BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
            String line;
            while ((line = reader.readLine()) != null) {
                System.out.println("Python 输出: " + line);
            }

            // 等待进程结束
            int exitCode = process.waitFor();
            System.out.println("Python 脚本执行完成，退出码: " + exitCode);
        } catch (IOException e) {
            System.err.println("运行 Python 脚本时发生 IO 异常: " + e.getMessage());
            e.printStackTrace();
        } catch (InterruptedException e) {
            System.err.println("Python 脚本执行被中断: " + e.getMessage());
            e.printStackTrace();
        }
    }


    // 数据导入导出
    public void startDataTask() throws InterruptedException {
        System.out.println("执行数据导入导出");
//        List<SysJob> list = jobService.selectJobList();
//        TimeUnit.SECONDS.sleep(88);
    }

}
