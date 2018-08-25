defmodule BoundingBox.Store do
  @moduledoc """
  Module to maintaing our state
  """
  use Agent
  alias BoundingBox.Quadtree

  @doc """
  Starts a new bucket.
  """
  def start_link(name) do
    Agent.start_link(fn -> Quadtree.new() end, name: name)
  end

  @doc """
  Gets a value from the `bucket` by `key`.
  """
  def get_bounding_block(bucket, point) do
    Agent.get(bucket, fn quadtree ->
      Quadtree.get_bounding_block(quadtree, point)
    end)
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
  def put(bucket, value) do
    Agent.update(bucket, fn quadtree ->
      Quadtree.insert(quadtree, value)
    end)
  end

end
