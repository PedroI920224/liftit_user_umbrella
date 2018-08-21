defmodule LiftitUserDb.Rabbitmq.RpcServer do

  def call do
    {:ok, connection} = AMQP.Connection.open(host: "rabbitmq")
    {:ok, channel} = AMQP.Channel.open(connection)
    AMQP.Queue.declare(channel, "rpc_queue")
    AMQP.Basic.qos(channel, prefetch_count: 1)
    AMQP.Basic.consume(channel, "rpc_queue")
    IO.puts " [x] Awaiting RPC requests"
    LiftitUserDb.Rabbitmq.RpcServer.wait_for_messages(channel)
  end

  def wait_for_messages(channel) do
    receive do
      {:basic_deliver, payload, meta} ->
        IO.puts " [.] fib(#{payload})"
        changes = LiftitUserDb.User.Handler.try_saved_data(payload)
        response = :erlang.term_to_binary(changes)

        AMQP.Basic.publish(channel, "", meta.reply_to, response,
          correlation_id: meta.correlation_id)
        AMQP.Basic.ack(channel, meta.delivery_tag)

        wait_for_messages(channel)
    end
  end
end
LiftitUserDb.Rabbitmq.RpcServer.call
