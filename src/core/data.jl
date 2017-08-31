function process_additional_data(data)
  mva_base = data["baseMVA"]
  rescale = x -> x/mva_base
  rescale_cost = x -> mva_base * x
  if haskey(data, "load")
      for (i, load) in data["load"]
        PowerModels.apply_func(load, "pref", rescale)
        PowerModels.apply_func(load, "qref", rescale)
        PowerModels.apply_func(load, "pmin", rescale)
        PowerModels.apply_func(load, "pmax", rescale)
        PowerModels.apply_func(load, "qmin", rescale)
        PowerModels.apply_func(load, "qmax", rescale)
        PowerModels.apply_func(load, "prated", rescale)
        PowerModels.apply_func(load, "qrated", rescale)
        PowerModels.apply_func(load, "voll", rescale_cost)
      end
    end
    if haskey(data["gen"],"1") && haskey(data["gen"]["1"], "prated")
        for (i, gen) in data["gen"]
          PowerModels.apply_func(gen, "pref", rescale)
          PowerModels.apply_func(gen, "qref", rescale)
          PowerModels.apply_func(gen, "prated", rescale)
          PowerModels.apply_func(gen, "qrated", rescale)
        end
    end
    if haskey(data["branch"], "shiftable")
          for (i, branch) in data["branch"]
              PowerModels.apply_func(branch, "shift_fr", PowerModels.deg2rad)
              PowerModels.apply_func(branch, "shift_to", PowerModels.deg2rad)
              PowerModels.apply_func(branch, "shift_fr_max", PowerModels.deg2rad)
              PowerModels.apply_func(branch, "shift_fr_min", PowerModels.deg2rad)
              PowerModels.apply_func(branch, "shift_to_max", PowerModels.deg2rad)
              PowerModels.apply_func(branch, "shift_to_min", PowerModels.deg2rad)
          end
    end
end