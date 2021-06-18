package ConduitApp;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

@KarateOptions( tags = {"debug", "regression"})
class ConduitTest {

    // this will run all *.feature files that exist in sub-directories
    // see https://github.com/intuit/karate#naming-conventions

// @Karate.Test
// Karate testAll() {
//     return Karate.run().relativeTo(getClass());
// }

@Test
void testParallel() {
    Results results = Runner.path("classpath:ConduitApp").tags("~@ignore").parallel(1);
    assertEquals(0, results.getFailCount(), results.getErrorMessages());
}

}
