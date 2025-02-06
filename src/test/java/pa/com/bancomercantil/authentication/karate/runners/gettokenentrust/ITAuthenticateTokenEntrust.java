package pa.com.bancomercantil.authentication.karate.runners.gettokenentrust;

import com.intuit.karate.junit5.Karate;

public class ITAuthenticateTokenEntrust {


    @Karate.Test
    Karate userGet(){
        return Karate.run("classpath:pa/com/bancomercantil/karate/authentication/features/userstatus.feature")
               .tags("@concurrent")
                .relativeTo(getClass());
    }
}
