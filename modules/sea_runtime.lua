local M = {}

function M.ResetCombatAttempt(state, virtualInputManager)
    local env = getgenv()
    env.IKARO_SEA_SKILL_AIM_ACTIVE = false
    state.BMPreparedEvent = nil
    state.BMPreparedTool = nil
    state.BMEquipReadyAt = 0

    if virtualInputManager then
        for _, keyCode in ipairs({
            Enum.KeyCode.Z, Enum.KeyCode.X, Enum.KeyCode.C,
            Enum.KeyCode.V, Enum.KeyCode.F, Enum.KeyCode.Q
        }) do
            pcall(function()
                virtualInputManager:SendKeyEvent(false, keyCode, false, game)
            end)
        end
    end
end

function M.DepartureHeight(position, tikiPosition, normalHeight, returningHeart, atSea6)
    if returningHeart or atSea6 or not position or not tikiPosition then
        return normalHeight
    end

    local deltaX = position.X - tikiPosition.X
    local deltaZ = position.Z - tikiPosition.Z
    local horizontalDistance = math.sqrt(deltaX * deltaX + deltaZ * deltaZ)
    return horizontalDistance <= 2200 and 200 or normalHeight
end

return M
