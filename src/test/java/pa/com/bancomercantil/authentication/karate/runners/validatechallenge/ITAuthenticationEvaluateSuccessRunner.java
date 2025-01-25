package pa.com.bancomercantil.authentication.karate.runners.validatechallenge;

import com.intuit.karate.junit5.Karate;

public class ITAuthenticationEvaluateSuccessRunner {
    @Karate.Test
    Karate authenticationEvaluateSuccessTest() {
        return Karate.run("classpath:pa/com/bancomercantil.authentication/karate/validatechallenge/features/validatechallengesuccess.feature")
                .relativeTo(getClass());
    }
}
