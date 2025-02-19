package pa.com.bancomercantil.authentication.karate.runners.managerpassword;

import com.intuit.karate.junit5.Karate;

public class ITManagerPassword {
    @Karate.Test
    Karate userGet(){
        return Karate.run("classpath:pa/com/bancomercantil/authentication/karate/managerPassword/features/managerpassword.feature")
                .relativeTo(getClass());
    }
}
