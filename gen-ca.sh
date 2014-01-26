#!/bin/sh

if [ ! -e serial ]; then
    echo -n '01' > serial
fi

if [ ! -e values.sh ]; then
    cat values.sample.sh > values.sh
    chmod +x values.sh
fi
. ./values.sh

if [ "$ca_protect" = "no" ]; then
    ca_extra_opts="${ca_extra_opts} -nodes"
fi

openssl req -new -x509 -keyout "${ca_name}.key" -keyform $format -out "${ca_name}.crt" -outform $format -days $ca_days -newkey rsa:$ca_size -subj "${ca_subj}" ${ca_extra_opts}