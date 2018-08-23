#!/usr/bin/env bash
command () {
  ./wait-for-it.sh rabbitmq:5672 -- mix phx.server &
  ./wait-for-it.sh rabbitmq:15672
}

second_group () {
  cd /liftit_user_umbrella/apps/liftit_user_db/ & mix run -e "LiftitUserDb.Rabbitmq.RpcServer.call()"
}
echo First Group:
echo "hoooooooooooooooooooooooooooooooooooooooooolaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" &
command &
echo "finfinfinfinfinfinfinfinfinfinfinfinfinfinfinfinfinfinfinfinfinfinfinfinfinfinfin"
wait
echo Secount Group:
echo "---------------------------------------------------------------------------------"
echo "---------------------------------------------------------------------------------"
echo "[X] ----------UPDATING QUEUE RPC-SERVER RABBITMQ IN LIFTIT_USER_DB---------------" &
second_group
