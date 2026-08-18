local M = {}

M.Tiki = Vector3.new(-16209.3115234375, 9.123141288757324, 436.32470703125)
M.Sea6 = Vector3.new(-44718.37109375, 24.00019073486328, 150.4124755859375)
M.Direction = Vector3.new(-0.9999496936798096, 0, -0.010028315708041191)
M.Distance = 28510.4921875
M.HydraHeartDestination = Vector3.new(5433, 35, 290)

function M.Sea6Target(height)
    return Vector3.new(M.Sea6.X, height, M.Sea6.Z)
end

function M.FlatDirection(from, destination)
    local delta = Vector3.new(destination.X - from.X, 0, destination.Z - from.Z)
    return delta.Magnitude > 1 and delta.Unit or M.Direction
end

return M
