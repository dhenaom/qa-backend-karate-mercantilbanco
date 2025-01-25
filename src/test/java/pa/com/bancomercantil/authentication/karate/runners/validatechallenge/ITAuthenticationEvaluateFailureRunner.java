package pa.com.bancomercantil.authentication.karate.runners.validatechallenge;

import com.intuit.karate.junit5.Karate;

public class ITAuthenticationEvaluateFailureRunner {
    @Karate.Test
    Karate authenticationEvaluateFailureTest() {
        return Karate.run("classpath:pa/com/bancomercantil.authentication/karate/validatechallenge/features/validatechallengefailure.feature")
                .relativeTo(getClass());
    }
}
