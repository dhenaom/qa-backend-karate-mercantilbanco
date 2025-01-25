package pa.com.bancomercantil.authentication.karate.runners.requestchallenge;
import com.intuit.karate.junit5.Karate;

public class ITRequestChallengeSuccessRunner {
    @Karate.Test
    Karate challengeSuccessTest() {
        return Karate.run("classpath:pa/com/bancomercantil.authentication/karate/requestchallenge/features/requestchallengesuccess.feature@HappyPath")
                .relativeTo(getClass());
    }
}