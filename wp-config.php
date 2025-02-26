<?php

/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'wordpressuser' );

/** MySQL database password */
define( 'DB_PASSWORD', 'password' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 */
define('AUTH_KEY', 't M&L&56FEZS@I$(aZ9?,R7O!pBQ~q=-A[qb]zA-YD;2;r`64nr+fTTaC+/9)VC|');
define('SECURE_AUTH_KEY', 'IP,~&5<3`d8*]gIKhN/Up/{I:P{rbGsFOvn&2wY|gcKu@%{l#$M/RHa|5iRagn/2');
define('LOGGED_IN_KEY', 'u-dA~MEE&X@|}2OK,-n3v,vgoe$NJCWl!NOIo<Sc9H7b+CI{.v-}>xTG8^b~|qi!');
define('NONCE_KEY', '>6Q+*Kp&~vA|DAkC,1e-l&J3n=oS##-qFl./G!H_d|i`-^H5Z7A`Ioh8c}k$/$Ct');
define('AUTH_SALT', '}MfxME5xrgNe5|$oN5 K#tiiaR^JK|:VV[k&I=%XcR}#Y+7~1^@_D:p<$VyUZ4da');
define('SECURE_AUTH_SALT', '%&+MZ|H@1Xx|+4<P9!tWj)Vf04</hg-*f9+ab:c9%qoOvuUVw }cRcDhDw/K@]+s');
define('LOGGED_IN_SALT', 'OeR/5<eg:*+1$m%}{FW !D[WxUtcS6rKI*E;2hwCs?~C!UkAd-IT%?.fnbqz@rSr');
define('NONCE_SALT', 'j.ST.MY~0<Ws!Fe:lw%fy6K*Eh$mwQ7Z4oTM7w!zH:[]L1#Hz6CIf$:Z9n5}yFHQ');
/**#@-*/

$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
