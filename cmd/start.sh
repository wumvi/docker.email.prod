#!/bin/bash

source /lib-utils
/dkim-create.sh

# Всё запускаем
/exim-reload.sh
/multi-tail.sh /var/mail/mail /var/log/exim4/* &

# Ждём SIGTERM или SIGINT
wait_signal

# Запрашиваем остановку
pkill -x exim4
pkill -x tail

# Ждём завершения процессов по их названию
wait_exit "exim4"
