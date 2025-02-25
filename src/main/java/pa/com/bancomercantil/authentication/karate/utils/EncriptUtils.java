package pa.com.bancomercantil.authentication.karate.utils;
import com.mercantil.encryption.application.dto.EncryptionRequest;
import com.mercantil.encryption.application.dto.EncryptionResponse;
import com.mercantil.encryption.application.usecases.EncryptDataUseCase;
import com.mercantil.encryption.crosscutting.secrets.ISecretService;
import com.mercantil.encryption.crosscutting.secrets.SecretService;
import com.mercantil.encryption.domain.ports.EncryptionPort;
import com.mercantil.encryption.domain.services.EncryptionService;
import com.mercantil.encryption.infraestructure.adapters.EncryptionAdapter;

public class EncriptUtils
{
    
    ISecretService secretService = new SecretService();
    EncryptionPort encryptionPort = new EncryptionAdapter(secretService);
    EncryptionService encryptionService = new EncryptionService(encryptionPort);
    EncryptDataUseCase encryptUseCase = new EncryptDataUseCase(encryptionService);


    public String encryptData(String data, String transactionId,String algorithmAlias) {
        EncryptionResponse encryptionResponse = null;
        if (algorithmAlias.equals("AES")) {
            EncryptionRequest encryptionRequestAES = EncryptionRequest.builder()
                    .plainText(data)
                    .keyAlias("aes-key")
                    .algorithmAlias("AES")
                    .transactionId(transactionId)
                    .build();

            encryptionResponse = encryptUseCase.execute(encryptionRequestAES);
        }else {
            EncryptionRequest encryptionRequestRSA = EncryptionRequest.builder()
                    .plainText(data)
                    .keyAlias("rsa-private-key")
                    .algorithmAlias("RSA")
                    .transactionId(transactionId)
                    .build();

            encryptionResponse = encryptUseCase.execute(encryptionRequestRSA);

        }
        return encryptionResponse.getCipherText();

    }


}


