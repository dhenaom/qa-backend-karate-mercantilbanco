package pa.com.bancomercantil.authentication.karate.runners.requestchallenge;
import com.intuit.karate.junit5.Karate;

public class ITRequestChallengeFailureRunner {
    @Karate.Test
    Karate challengeFailureTest() {
        return Karate.run("classpath:pa/com/bancomercantil.authentication/karate/requestchallenge/features/requestchallengefailure.feature")
                .relativeTo(getClass());
    }
}