defmodule SphearUtils.Ecto.Changeset do
  import Ecto.Changeset,
    only: [
      add_error: 3,
      get_field: 2,
      traverse_errors: 2,
      validate_change: 3,
      validate_required: 3,
      change: 2,
      assoc_constraint: 2
    ]

  @doc """
  A helper that transforms changeset errors into a map of messages.

  ## Examples

    iex> changeset = Ecto.Changeset.change({%{}, %{password: :string}}) |> Ecto.Changeset.cast(%{password: 123}, [:password])
    iex> assert "is invalid" in SphearUtils.Ecto.Changeset.errors_on(changeset).password
    iex> assert %{password: ["is invalid"]} = SphearUtils.Ecto.Changeset.errors_on(changeset)
  """
  @spec errors_on(Ecto.Changeset.t()) :: %{optional(atom) => [binary]}
  def errors_on(changeset) do
    traverse_errors(changeset, fn {message, opts} ->
      Enum.reduce(opts, message, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end

  @spec validate_required_one_exclusive(Ecto.Changeset.t(), [any], keyword) :: Ecto.Changeset.t()
  def validate_required_one_exclusive(%Ecto.Changeset{} = changeset, fields, opts \\ [])
      when length(fields) > 0 do
    key = Keyword.get(opts, :key, List.first(fields)) |> to_string() |> String.to_atom()

    case Enum.count(fields, &get_field(changeset, &1)) do
      0 ->
        changeset
        |> add_error(key, "one of #{inspect(fields)} must be present")

      1 ->
        changeset

      _ ->
        changeset
        |> add_error(key, "only one of #{inspect(fields)} must be present")
    end
  end

  @spec validate_required_any(Ecto.Changeset.t(), list, keyword) :: Ecto.Changeset.t()
  def validate_required_any(%Ecto.Changeset{} = changeset, fields, opts \\ [])
      when length(fields) > 1 do
    key = Keyword.get(opts, :key, List.first(fields)) |> to_string() |> String.to_atom()
    min = Keyword.get(opts, :min, 1)
    message = Keyword.get(opts, :message, "at least #{min} of #{inspect(fields)} can't be blank")

    if Enum.count(fields, &get_field(changeset, &1)) < min do
      changeset |> add_error(key, message)
    else
      changeset
    end
  end

  @spec validate_required_if(Ecto.Changeset.t(), any, atom, any, keyword) :: Ecto.Changeset.t()
  def validate_required_if(
        %Ecto.Changeset{} = changeset,
        fields,
        conditional_field,
        expected_value,
        opts \\ []
      )
      when is_atom(conditional_field) do
    fields = List.wrap(fields)
    conditional_field_value = get_field(changeset, conditional_field)

    message =
      Keyword.get(opts, :message, "can't be blank when #{conditional_field} is #{expected_value}")

    if conditional_field_value == expected_value do
      changeset |> validate_required(fields, message: message)
    else
      changeset
    end
  end

  @spec validate_required_unless(Ecto.Changeset.t(), any, atom, any, keyword) ::
          Ecto.Changeset.t()
  def validate_required_unless(
        %Ecto.Changeset{} = changeset,
        fields,
        conditional_field,
        expected_value,
        opts \\ []
      )
      when is_atom(conditional_field) do
    fields = List.wrap(fields)
    conditional_field_value = get_field(changeset, conditional_field)

    message =
      Keyword.get(
        opts,
        :message,
        "can't be blank unless #{conditional_field} is #{expected_value}"
      )

    unless conditional_field_value == expected_value do
      changeset |> validate_required(fields, message: message)
    else
      changeset
    end
  end

  @spec validate_required_any_if(Ecto.Changeset.t(), any, atom, any, keyword) ::
          Ecto.Changeset.t()
  def validate_required_any_if(
        %Ecto.Changeset{} = changeset,
        fields,
        conditional_field,
        expected_value,
        opts \\ []
      )
      when length(fields) > 1 and is_atom(conditional_field) do
    min = Keyword.get(opts, :min, 1)
    fields = List.wrap(fields)
    conditional_field_value = get_field(changeset, conditional_field)

    message =
      Keyword.get(
        opts,
        :message,
        "at least #{min} of #{inspect(fields)} can't be blank when #{conditional_field} is #{
          expected_value
        }"
      )

    if conditional_field_value == expected_value do
      changeset |> validate_required_any(fields, Keyword.merge(opts, message: message))
    else
      changeset
    end
  end

  @spec validate_required_any_unless(Ecto.Changeset.t(), any, atom, any, keyword) ::
          Ecto.Changeset.t()
  def validate_required_any_unless(
        %Ecto.Changeset{} = changeset,
        fields,
        conditional_field,
        expected_value,
        opts \\ []
      )
      when is_atom(conditional_field) do
    min = Keyword.get(opts, :min, 1)
    fields = List.wrap(fields)
    conditional_field_value = get_field(changeset, conditional_field)

    message =
      Keyword.get(
        opts,
        :message,
        "at least #{min} of #{inspect(fields)} can't be blank unless #{conditional_field} is #{
          expected_value
        }"
      )

    unless conditional_field_value == expected_value do
      changeset |> validate_required_any(fields, Keyword.merge(opts, message: message))
    else
      changeset
    end
  end

  @spec validate_required_with(Ecto.Changeset.t(), any, atom | [atom], keyword) ::
          Ecto.Changeset.t()
  def validate_required_with(changeset, fields, conditional_fields, opts \\ [])

  def validate_required_with(
        %Ecto.Changeset{} = changeset,
        fields,
        conditional_field,
        opts
      )
      when is_atom(conditional_field) do
    fields = List.wrap(fields)

    opts =
      opts |> Keyword.put_new(:message, "can't be blank when #{conditional_field} is present")

    changeset
    |> validate_required_with(fields, [conditional_field], opts)
  end

  def validate_required_with(
        %Ecto.Changeset{} = changeset,
        fields,
        conditional_fields,
        opts
      )
      when length(conditional_fields) > 0 do
    fields = List.wrap(fields)

    message =
      Keyword.get(
        opts,
        :message,
        "can't be blank when any of #{inspect(conditional_fields)} are present"
      )

    if Enum.any?(conditional_fields, &(not is_nil(get_field(changeset, &1)))) do
      changeset |> validate_required(fields, message: message)
    else
      changeset
    end
  end

  @spec validate_required_with_all(Ecto.Changeset.t(), any, [atom], keyword) :: Ecto.Changeset.t()
  def validate_required_with_all(
        %Ecto.Changeset{} = changeset,
        fields,
        conditional_fields,
        opts \\ []
      )
      when length(conditional_fields) > 0 do
    fields = List.wrap(fields)

    message =
      Keyword.get(
        opts,
        :message,
        "can't be blank when #{Enum.join(conditional_fields, " and ")} are present"
      )

    if Enum.all?(conditional_fields, &(not is_nil(get_field(changeset, &1)))) do
      changeset |> validate_required(fields, message: message)
    else
      changeset
    end
  end

  @spec validate_required_without(Ecto.Changeset.t(), any, atom | [atom], keyword) ::
          Ecto.Changeset.t()
  def validate_required_without(changeset, fields, conditional_fields, opts \\ [])

  def validate_required_without(
        %Ecto.Changeset{} = changeset,
        fields,
        conditional_field,
        opts
      )
      when is_atom(conditional_field) do
    fields = List.wrap(fields)

    opts =
      opts |> Keyword.put_new(:message, "can't be blank when #{conditional_field} is not present")

    changeset
    |> validate_required_without(fields, [conditional_field], opts)
  end

  def validate_required_without(
        %Ecto.Changeset{} = changeset,
        fields,
        conditional_fields,
        opts
      )
      when length(conditional_fields) > 0 do
    fields = List.wrap(fields)

    message =
      Keyword.get(
        opts,
        :message,
        "can't be blank when any of #{inspect(conditional_fields)} is not present"
      )

    if Enum.any?(conditional_fields, &is_nil(get_field(changeset, &1))) do
      changeset |> validate_required(fields, message: message)
    else
      changeset
    end
  end

  @spec validate_required_without_all(Ecto.Changeset.t(), any, [atom], keyword) ::
          Ecto.Changeset.t()
  def validate_required_without_all(
        %Ecto.Changeset{} = changeset,
        fields,
        conditional_fields,
        opts \\ []
      )
      when length(conditional_fields) > 0 do
    fields = List.wrap(fields)

    message =
      Keyword.get(
        opts,
        :message,
        "can't be blank when #{Enum.join(conditional_fields, " and ")} are not present"
      )

    if Enum.all?(conditional_fields, &is_nil(get_field(changeset, &1))) do
      changeset |> validate_required(fields, message: message)
    else
      changeset
    end
  end

  @doc """
  Validates the given `fields` change are empty or unchanged.
  """
  @spec validate_empty(Ecto.Changeset.t(), any, keyword) :: Ecto.Changeset.t()
  def validate_empty(%Ecto.Changeset{} = changeset, fields, opts \\ []) do
    fields = List.wrap(fields)
    message = Keyword.get(opts, :message, "can't be set")

    fields
    |> Enum.reduce(changeset, fn field, acc ->
      acc
      |> validate_change(field, fn field, _field_changeset ->
        [{field, message}]
      end)
    end)
  end

  @spec validate_empty_if(Ecto.Changeset.t(), any, atom, any, keyword) :: Ecto.Changeset.t()
  def validate_empty_if(
        %Ecto.Changeset{} = changeset,
        fields,
        conditional_field,
        expected_value,
        opts \\ []
      )
      when is_atom(conditional_field) do
    fields = List.wrap(fields)
    conditional_field_value = get_field(changeset, conditional_field)

    message =
      Keyword.get(opts, :message, "can't be set when #{conditional_field} is #{expected_value}")

    if conditional_field_value == expected_value do
      changeset |> validate_empty(fields, message: message)
    else
      changeset
    end
  end

  @spec validate_empty_unless(Ecto.Changeset.t(), any, atom, any, keyword) :: Ecto.Changeset.t()
  def validate_empty_unless(
        %Ecto.Changeset{} = changeset,
        fields,
        conditional_field,
        expected_value,
        opts \\ []
      )
      when is_atom(conditional_field) do
    fields = List.wrap(fields)
    conditional_field_value = get_field(changeset, conditional_field)

    message =
      Keyword.get(opts, :message, "can't be set unless #{conditional_field} is #{expected_value}")

    unless conditional_field_value == expected_value do
      changeset |> validate_empty(fields, message: message)
    else
      changeset
    end
  end

  @spec validate_empty_with(Ecto.Changeset.t(), any, atom | [atom], keyword) ::
          Ecto.Changeset.t()
  def validate_empty_with(changeset, fields, conditional_fields, opts \\ [])

  def validate_empty_with(
        %Ecto.Changeset{} = changeset,
        fields,
        conditional_field,
        opts
      )
      when is_atom(conditional_field) do
    fields = List.wrap(fields)

    opts = opts |> Keyword.put_new(:message, "can't be set when #{conditional_field} is present")

    changeset
    |> validate_empty_with(fields, [conditional_field], opts)
  end

  def validate_empty_with(
        %Ecto.Changeset{} = changeset,
        fields,
        conditional_fields,
        opts
      )
      when length(conditional_fields) > 0 do
    fields = List.wrap(fields)

    message =
      Keyword.get(
        opts,
        :message,
        "can't be set when any of #{inspect(conditional_fields)} are present"
      )

    if Enum.any?(conditional_fields, &(not is_nil(get_field(changeset, &1)))) do
      changeset |> validate_empty(fields, message: message)
    else
      changeset
    end
  end

  @spec validate_empty_with_all(Ecto.Changeset.t(), any, [atom], keyword) :: Ecto.Changeset.t()
  def validate_empty_with_all(
        %Ecto.Changeset{} = changeset,
        fields,
        conditional_fields,
        opts \\ []
      )
      when length(conditional_fields) > 0 do
    fields = List.wrap(fields)

    message =
      Keyword.get(
        opts,
        :message,
        "can't be blank when #{Enum.join(conditional_fields, " and ")} are present"
      )

    if Enum.all?(conditional_fields, &(not is_nil(get_field(changeset, &1)))) do
      changeset |> validate_empty(fields, message: message)
    else
      changeset
    end
  end

  @spec validate_empty_without(Ecto.Changeset.t(), any, atom | [atom], keyword) ::
          Ecto.Changeset.t()
  def validate_empty_without(changeset, fields, conditional_fields, opts \\ [])

  def validate_empty_without(
        %Ecto.Changeset{} = changeset,
        fields,
        conditional_field,
        opts
      )
      when is_atom(conditional_field) do
    fields = List.wrap(fields)

    opts =
      opts |> Keyword.put_new(:message, "can't be set when #{conditional_field} is not present")

    changeset
    |> validate_empty_without(fields, [conditional_field], opts)
  end

  def validate_empty_without(
        %Ecto.Changeset{} = changeset,
        fields,
        conditional_fields,
        opts
      )
      when length(conditional_fields) > 0 do
    fields = List.wrap(fields)

    message =
      Keyword.get(
        opts,
        :message,
        "can't be set when any of #{inspect(conditional_fields)} is not present"
      )

    if Enum.any?(conditional_fields, &is_nil(get_field(changeset, &1))) do
      changeset |> validate_empty(fields, message: message)
    else
      changeset
    end
  end

  @spec validate_empty_without_all(Ecto.Changeset.t(), any, [atom], keyword) ::
          Ecto.Changeset.t()
  def validate_empty_without_all(
        %Ecto.Changeset{} = changeset,
        fields,
        conditional_fields,
        opts \\ []
      )
      when length(conditional_fields) > 0 do
    fields = List.wrap(fields)

    message =
      Keyword.get(
        opts,
        :message,
        "can't be set when #{Enum.join(conditional_fields, " and ")} are not present"
      )

    if Enum.all?(conditional_fields, &is_nil(get_field(changeset, &1))) do
      changeset |> validate_empty(fields, message: message)
    else
      changeset
    end
  end

  def validate_if_present(changeset, field) do
    case get_field(changeset, field) do
      nil ->
        changeset
      _field_value -> 
        without_id = field |> Atom.to_string |> String.replace_suffix("_id", "") |> String.to_existing_atom
        assoc_constraint(changeset, without_id)
    end
  end

  def validate_one_of_present(changeset, fields) do
    fields
    |> Enum.filter(fn field ->
      # Checks if a field is "present".
      # The logic is copied from `validate_required` in Ecto.
      case get_field(changeset, field) do
        nil -> false
        _ -> true
      end
    end)
    |> case do
      # Exactly one field was present.
      [field] ->
        without_id = field |> Atom.to_string |> String.replace_suffix("_id", "") |> String.to_existing_atom
        assoc_constraint(changeset, without_id)
      # Zero or more than one fields were present.
      _ ->
        add_error(changeset, hd(fields), "expected exactly one of #{inspect(fields)} to be present")
    end
  end

  def validate_one_or_none_of_present(changeset, fields) do
    fields
    |> Enum.filter(fn field ->
      # Checks if a field is "present".
      # The logic is copied from `validate_required` in Ecto.
      case get_field(changeset, field) do
        nil -> false
        binary when is_binary(binary) -> String.trim_leading(binary) == ""
        _ -> true
      end
    end)
    |> case do
      # Exactly one field was present. -> Ok
      [new_constraint] ->
        without_id = new_constraint |> Atom.to_string |> String.replace_suffix("_id", "") |> String.to_existing_atom
        changeset
        |> assoc_constraint(without_id)
        |> remove_old_constraints(new_constraint, fields)
      # None of the fields were present -> Ok
      [] ->
        # Do nothing (or none)
        changeset
      # More than one fields were present. -> Error
      _ ->
        add_error(changeset, hd(fields), "expected only one of #{inspect(fields)} to be present")
    end
  end

  def remove_old_constraints(changeset, new_constraint, fields) do
    fields
    |> Enum.filter(fn field ->
      # Filter away the new_constraint from the fields
      case get_field(changeset, field) do
        ^new_constraint -> false
        nil -> false
        _old_constraint -> true
      end
    end)
    |> case do
      # Remove old_constraints
      old_constraints when is_list(old_constraints) ->
        changeset =
          for old_constraint <- old_constraints do
            change(changeset, {String.to_existing_atom(old_constraint), nil})
          end
        changeset
      _ ->
        # Do nothing
        changeset
    end
  end
end