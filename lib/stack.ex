defmodule Stack do
  def start_link do
    pid = spawn_link(__MODULE__, :loop, [[]])
    {:ok, pid}
  end

  def loop(stack) do
    receive do
      {:size, sender} ->
        send(sender, {:ok, Enum.count(stack)})
      {:push, item} -> stack = [item | stack]
      {:pop, sender} ->
        [item | stack] = stack
        send(sender, {:ok, item})
    end
    loop(stack)
  end

  def size(pid) do
    send pid, {:size, self}
    receive do {:ok, size} -> size end
  end

  def push(pid, item) do
    send pid, {:push, item}
  end

  def pop(pid) do
    send pid, {:pop, self}
    receive do {:ok, item} -> item end
  end
end
