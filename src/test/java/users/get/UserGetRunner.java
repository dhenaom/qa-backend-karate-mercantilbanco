package users.get;

import com.intuit.karate.junit5.Karate;

public class UserGetRunner {

    @Karate.Test
    Karate userGet(){
//        Si dejamos el run vacio Karate entiende que queremos correr todos los features que este dentro del mismo package del Runner
        return Karate.run().relativeTo(getClass());
    }
}
