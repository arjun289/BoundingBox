defmodule BoundingBox.CarpoolStore do
  @moduledoc """
  Module to maintaing our state
  """
  use Agent

  @doc """
  Starts a new bucket.
  """
  def start_link(name) do
    Agent.start_link(fn -> %{} end, name: name)
  end

  @doc """
  Gets a value from the `bucket` by `key`.
  """
  def get(bucket, key) do
    Agent.get(bucket, &Map.get(&1, key))
  end

  @doc """
  Returns the entire bucket.
  """
  def get_all(bucket) do
    Agent.get(bucket, fn state -> state end)
  end

  @doc """
  Puts the `value` for the given `key` in the `bucket`.
  """
  def put(bucket, key, value) do
    Agent.update(bucket, &Map.put(&1, key, value))
  end

  def delete(bucket, key) do
    Agent.get_and_update(bucket, fn dict ->
      Map.pop(dict, key)
    end)
  end

end
