package pa.com.bancomercantil.authentication.karate.runners.createuser;

import com.intuit.karate.junit5.Karate;

public class ITCreateuser {
    @Karate.Test
    Karate userGet(){
        return Karate.run("classpath:pa/com/bancomercantil/authentication/karate/createuser/features/createuser.feature")
                .relativeTo(getClass());
    }
}
