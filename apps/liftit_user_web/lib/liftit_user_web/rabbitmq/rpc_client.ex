defmodule LiftitUserWeb.Rabbitmq.RpcClient do
  def wait_for_messages(_channel, correlation_id) do
    receive do
      {:basic_deliver, payload, %{correlation_id: ^correlation_id}} ->
        term_payload = :erlang.binary_to_term(payload)
        {status, body} = term_payload
        term_payload
    end
  end
  def call(user_data) do
    {:ok, connection} = AMQP.Connection.open(host: "rabbitmq")
    {:ok, channel} = AMQP.Channel.open(connection)

    {:ok, %{queue: queue_name}} = AMQP.Queue.declare(channel,
                                                     "",
                                                     exclusive: true)
    AMQP.Basic.consume(channel, queue_name, nil, no_ack: true)
    correlation_id =
      :erlang.unique_integer
      |> :erlang.integer_to_binary
      |> Base.encode64

    AMQP.Basic.publish(channel, "", "rpc_queue", user_data,
      reply_to: queue_name, correlation_id: correlation_id)

    LiftitUserWeb.Rabbitmq.RpcClient.wait_for_messages(channel, correlation_id)
  end
end
