defmodule StackTest do
  use ExUnit.Case
  doctest Stack

  test "size is zero when empty" do
    {:ok, pid} = Stack.start_link
    assert Stack.size(pid) == 0
  end

  test "push adds to the stack" do
    {:ok, pid} = Stack.start_link
    Stack.push pid, :foo
    assert Stack.size(pid) == 1
  end

  test "pop removes one from the stack" do
    {:ok, pid} = Stack.start_link
    Stack.push(pid, :bar)
    Stack.push(pid, :foo)
    assert Stack.pop(pid) == :foo
    assert Stack.size(pid) == 1
  end
end
