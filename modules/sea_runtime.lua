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
    if returningHeart or not position or not tikiPosition then
        return normalHeight
    end

    local deltaX = position.X - tikiPosition.X
    local deltaZ = position.Z - tikiPosition.Z
    local horizontalDistance = math.sqrt(deltaX * deltaX + deltaZ * deltaZ)
    -- Tiki possui muralhas e estruturas altas ao redor do cais. Mantém a
    -- altitude de liberação até o barco estar completamente fora da ilha.
    -- Baseado somente na posição: também funciona após morte, reset, recompra
    -- ou quando AtSea6 ainda pertence à viagem anterior.
    return horizontalDistance <= 3000 and 500 or normalHeight
end

return M
