defmodule Stack do
  use GenServer

  def start_link do
    GenServer.start_link __MODULE__, []
  end

  def size(pid) do
    GenServer.call pid, :size
  end

  def push(pid, item) do
    GenServer.cast pid, {:push, item}
  end

  def pop(pid) do
    GenServer.call pid, :pop
  end

  # GenServer implementation
  def handle_call(:size, _from, stack) do
    {:reply, Enum.count(stack), stack}
  end

  def handle_cast({:push, item}, stack) do
    {:noreply, [item | stack]}
  end

  def handle_call(:pop, _from, [item | rest]) do
    {:reply, item, rest}
  end
end
