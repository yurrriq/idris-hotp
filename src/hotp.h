#ifndef HOTP_H
#define HOTP_H
void two_plus_two_is();
int add_two( int x );
char *sha256_digest( const char *str );
char *hmac_cons( const char *secret, const char *data );
#endif
