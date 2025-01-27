package pa.com.bancomercantil.authentication.karate.runners.validatechallenge;

import com.intuit.karate.junit5.Karate;

public class ITKBAGetQuestionSuccessRunner {
    @Karate.Test
    Karate kbaQuestionEvaluateSuccessTest() {
        return Karate.run("classpath:pa/com/bancomercantil.authentication/karate/validatechallenge/features/getquestionsandanswers.feature")
                .relativeTo(getClass());
    }
}
