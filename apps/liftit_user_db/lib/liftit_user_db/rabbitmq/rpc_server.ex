defmodule Rabbitmq.RpcServer do

  def call do
    {:ok, connection} = AMQP.Connection.open(host: "rabbitmq")
    {:ok, channel} = AMQP.Channel.open(connection)
    AMQP.Queue.declare(channel, "rpc_queue")
    AMQP.Basic.qos(channel, prefetch_count: 1)
    AMQP.Basic.consume(channel, "rpc_queue")
    IO.puts " [x] Awaiting RPC requests"
    Rabbitmq.RpcServer.wait_for_messages(channel)
  end

  def wait_for_messages(channel) do
    receive do
      {:basic_deliver, payload, meta} ->
        IO.puts " [.] fib(#{payload})"
        alias LiftitUserDb.Models.User
        user_data = Poison.decode!(payload)
        changeset = User.changeset(%User{}, user_data)
        changes = LiftitUserDb.Repo.insert(changeset)
        response = :erlang.term_to_binary(changes)

        AMQP.Basic.publish(channel, "", meta.reply_to, response,
          correlation_id: meta.correlation_id)
        AMQP.Basic.ack(channel, meta.delivery_tag)

        wait_for_messages(channel)
    end
  end
end
Rabbitmq.RpcServer.call
