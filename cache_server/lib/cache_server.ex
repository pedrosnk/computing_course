defmodule CacheServer do
  use GenServer

  @name CacheServer

  def start_link do
    GenServer.start_link __MODULE__, %{}, name: @name
  end

  def write key, value do
    GenServer.cast @name, {:write, {key, value}}
  end

  def read key do
    GenServer.call @name, {:read, key}
  end

  def delete key do
    GenServer.cast @name, {:delete, key}
  end

  def clear do
    GenServer.cast @name, :clear
  end

  def exists? key do
    GenServer.call @name, {:exists?, key}
  end

  def init initial do
    {:ok, initial}
  end

  def handle_cast {:write, {key, value}}, stats do
    stats = Map.put stats, key, value
    {:noreply, stats}
  end

  def handle_cast {:delete, key}, stats do
    stats = Map.delete stats, key
    {:noreply, stats}
  end

  def handle_cast :clear, _stats do
    {:noreply, %{}}
  end

  def handle_call {:read, key}, _from, stats do
    {:reply, stats[key], stats}
  end

  def handle_call {:exists?, key}, _from, stats do
    {:reply, Map.has_key?(stats, key), stats}
  end

end
