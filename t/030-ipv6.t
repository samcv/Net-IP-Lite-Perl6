use v6;
use Test;

use Net::IP::Lite;

# valid
ok ip-is-ipv6 '1::1';
ok ip-is-ipv6 '1:a:c::1';
ok ip-is-ipv6 '::1';

# not valid
nok ip-is-ipv6 '1::1::1';
nok ip-is-ipv6 ':1';
nok ip-is-ipv6 '1:';
nok ip-is-ipv6 '1:2:3:4:5:6:7:8:9';
nok ip-is-ipv6 '1:a:c:1';

# valid
is ip-get-version('1::1'),     '6';
is ip-get-version('1:a:c::1'), '6';
is ip-get-version('::1'),      '6';

# not valid
is ip-get-version('a.2.3.4'),   '0';
is ip-get-version('1.2.3.4.5'), '0';

# expand
is ip-expand-address('1::1', 6),
  '0001:0000:0000:0000:0000:0000:0000:0001';

is ip-iptobin('1::1', 6),
  '00000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001';

is ip-bintoip('00000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001', 6),
  '0001:0000:0000:0000:0000:0000:0000:0001';

is ip-compress-address('0001:0000:0000:0000:0000:0000:0000:0001', 6),
  '1::1';

is ip-compress-address('0001:00e0:0000:0000:0000:0000:0000:0001', 6),
  '1:e0::1';

#is ip-compress-address('00.023.255', 4), '00.023.255';
is ip-compress-address('00.023.255', 4), '0.23.255';

is ip-reverse-address('00.023.255', 4), '255.23.0';
is ip-reverse-address('042.00.023.255', 4), '255.23.0.42';

is ip-reverse-address('0001:00e0:0000:0000:0000:0000:0000:0001', 6),
  '1.0.0.0.0.0.e0.1';

is ip-reverse-address('1:00e0::0001', 6),
  '1.0.0.0.0.0.e0.1';

done-testing;