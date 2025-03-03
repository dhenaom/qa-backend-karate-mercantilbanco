package pa.com.bancomercantil.account.karate.runners.getcurrentaccount;

import com.intuit.karate.junit5.Karate;
import pa.com.bancomercantil.authentication.karate.utils.ZipUtil;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class ITGetCurrentAccountSuccessRunner {

            @Karate.Test
            Karate getCurrentAccountSuccessTest() throws IOException {
                String timestamp = new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss").format(new Date());
                String path = "target/karate-reports-"+timestamp;
                Karate result = Karate.run("classpath:pa/com/bancomercantil/account/karate/getcurrentaccounts/features/getcurrentaccountssuccess.feature")
                        .relativeTo(getClass()).backupReportDir(true).outputCucumberJson(true);
                ZipUtil.zipDirectory("target/karate-reports", path + ".zip");
                return result;
            }
        }