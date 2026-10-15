--!strict
export type Logger = {
    info: (event: string, detail: string?) -> (),
    debug: (event: string, detail: string?) -> (),
    error: (event: string, detail: string?) -> (),
}

local Logger = {}

function Logger.new(scope: string, debugEnabled: boolean): Logger
    local function format(level: string, event: string, detail: string?): string
        return string.format("[The Relay Below][%s][%s] %s%s", scope, level, event,
            if detail then " | " .. detail else "")
    end

    return table.freeze({
        info = function(event: string, detail: string?)
            print(format("INFO", event, detail))
        end,
        debug = function(event: string, detail: string?)
            if debugEnabled then print(format("DEBUG", event, detail)) end
        end,
        error = function(event: string, detail: string?)
            warn(format("ERROR", event, detail))
        end,
    })
end

return table.freeze(Logger)
