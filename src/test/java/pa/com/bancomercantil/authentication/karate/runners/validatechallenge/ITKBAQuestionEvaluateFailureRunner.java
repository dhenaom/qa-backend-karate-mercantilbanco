package pa.com.bancomercantil.authentication.karate.runners.validatechallenge;

import com.intuit.karate.junit5.Karate;

public class ITKBAQuestionEvaluateFailureRunner {
    @Karate.Test
    Karate kbaQuestionEvaluateFailureTest() {
        return Karate.run("classpath:pa/com/bancomercantil.authentication/karate/validatechallenge/features/validatechallengekbafailure.feature")
                .relativeTo(getClass());
    }
}
