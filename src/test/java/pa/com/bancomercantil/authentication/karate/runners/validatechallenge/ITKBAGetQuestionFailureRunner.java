package pa.com.bancomercantil.authentication.karate.runners.validatechallenge;

import com.intuit.karate.junit5.Karate;

public class ITKBAGetQuestionFailureRunner {
    @Karate.Test
    Karate kbaQuestionEvaluateSuccessTest() {
        return Karate.run("classpath:pa/com/bancomercantil.authentication/karate/validatechallenge/features/getquestionsandanswersfailure.feature")
                .relativeTo(getClass());
    }
}
