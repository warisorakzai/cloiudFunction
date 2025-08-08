import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  Future<String> getServerKeytoken() async {
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];
    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson({
        "type": "service_account",
        "project_id": "gppp-d12b9",
        "private_key_id": "95683952147c826cfe32bcbd53f87d20bccaf395",
        "private_key":
            "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCi8aQTq8rrea0z\niuUpGzDWIakswUQvZVBMVkfky9T2M91a6b5OreW+YdWbrIOkEtB8eaLU5DRIOwbd\na8vTbX4bvwfiJxBIVDinBwR87AkIjToy9KWJ9gArYEDMDcFd4RzCD4A3FIfQqKJA\nfn6SlbR3MALylql6sm8ME8Gwb5uYaVwf2vOaFU6EUAxJmO3fCK1dNhVvkg2jF+CO\nS4kmAPzet3CdEOUSEV89mpD5FNDOUTZd/8FhM/UxCoy0ySuh/jYA61vvV0NjfONo\nAUYRrs33axProLBpAPxh4pXUf6/RE9b4TJDXhemA8i14ftOD6oMAQVmhwBkL4upE\n7IGs6uyrAgMBAAECggEAPj1AqAbhvqo+f0aZm+b384LuBNtZuSTg1BfM5Fb7ZIOR\nFK3d9F22OM9T8V+m9N/+5NztVpZIZiKtz5viQkM7fUutrjOvo4EQFrS2gSUDmlGf\nnmEWbikaDXd5qLfEWaCoBHQ5TFC6Q/h16V6n6EPop/Id3h2wZN6NTjapsEQhUcio\nvqjGbn8Fc87RIE7B4fR4nGARg7vBek/z9OPFe9FawXa9QKCooDZo9lV62A+gh+V5\n9YYxurCBp+HHVoqvjt1Dxl7USYcIeOCPK9E8GYbA5nI9b2yxVB5Ho3aRcrT3xzZa\nPH6bgWDDor6H6k3CKfLMP3f5/HR3zXv/dhz5SX60cQKBgQDSoWrr9pNaMzKXuOMG\neEtX1fyteTdo67rA/DWyM/CabzyLPHOlCYC8636QaqwoxUsDNHg0dvotn0BgWG8w\ncB8YGmj0MD+KRihcEhDxiLXdsmJYrKwPxqJsoJzlb4MFQy0H4F8/A+04xhxMj1iy\nxinQB1zRsgo2XSF1QMRvbSoNeQKBgQDGCrBSqvKpQY7L23+HFLLwLMjLAgzo3W7A\nRYB3sJ21efzjUXBk5B4LWXppUj3SXhvPV2IwwUGEesvOqYp2zAHW5sy+xTRwalCh\nwdMAX5ZXKqszeNtRxPg6OR/saTdsONDWfSFNCmr/ik8bYzc+Bc8d0OUByns73lI5\nV+11iIkWQwKBgQC97gBUNkw5EeGVHorY0rBdy//FDYEBg08rpkFlJ6DWIWgexawi\nLaeAs3m1D/ud6An0IeQiqwZ9DRUny5a3vuLLAUWSq88gCJNsMn5EzlnwR2KXQ10D\n/MGJ4mqYGS20GRcJ+zDnycqnXz01bC03R6l8hKcWD81VqDT7XiPDtlQtQQKBgGHp\nDO2CCMC3YbLVzUHqcOEfMxJy7BEA0O2MLwx9rCr5qZZ1P/0Rbu0risKhX2EvF861\npBz4nryxvStqVMOQ7uPhbZ5vfxKI7V5bpkcL+xcTSFsFSGEv4Y1firHl/vmpSU6R\nxLIDEY1PQvcGYVxvoMtb6Kyu/6hErSAeoY63NxdjAoGBAMq5WSniiNB+HZwL2FvY\nLXIrmqrqAwMgkWp18cgIRP0N9/loFUnRvJN1bDPl2WTVkJdjfp+/d1Kif94E1aTE\ngY6UHAUfX+48GfBNj+hyh+LxN2B3dxMzFNg+pMF7lSe5eAR3Qmg9uhDGkrs3HsbD\niZiZJbj2ng4mSbtXIudDqXdi\n-----END PRIVATE KEY-----\n",
        "client_email":
            "firebase-adminsdk-anris@gppp-d12b9.iam.gserviceaccount.com",
        "client_id": "113436738912654088139",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url":
            "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url":
            "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-anris%40gppp-d12b9.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com",
      }),
      scopes,
    );
    final acessServerKey = client.credentials.accessToken.data;

    return acessServerKey;
  }
}
