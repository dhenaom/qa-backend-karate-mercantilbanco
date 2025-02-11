package pa.com.bancomercantil.authentication.karate.runners.userstatus;

import com.intuit.karate.junit5.Karate;
import pa.com.bancomercantil.authentication.karate.utils.ZipUtil;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class ITUserStatus {

    @Karate.Test
    Karate userStatus() throws IOException {
        String timestamp = new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss").format(new Date());
        String path = "target/karate-reports-"+timestamp;
        Karate result = Karate.run("classpath:pa/com/bancomercantil.authentication/karate/userstatus/features/userstatus.feature")
                .relativeTo(getClass()).reportDir(path).outputCucumberJson(true);
        ZipUtil.zipDirectory("target/karate-reports", path + ".zip");
        return result;
    }
}

