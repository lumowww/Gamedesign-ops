// MCP Client for Qwen Code — Unity MCP Integration
// Версия: 1.0
// Проект: GAMEDEVGD

import { spawn } from 'child_process';
import { createInterface } from 'readline';

// Путь к MCP Unity серверу
const MCP_UNITY_PATH = 'd:/ASTRA/My project/Library/PackageCache/com.gamelovers.mcp-unity@e4b7e74ad052/Server~/build/index.js';
const PROJECT_PATH = 'd:/ASTRA/My project';

/**
 * MCP Client для вызова инструментов Unity MCP
 * @param {string} toolName - имя инструмента (например, 'get_scene_info')
 * @param {object} args - аргументы инструмента
 * @returns {Promise<object>} результат выполнения
 */
export async function callMcpTool(toolName, args = {}) {
  return new Promise((resolve, reject) => {
    const mcpProcess = spawn('node', [MCP_UNITY_PATH], {
      stdio: ['pipe', 'pipe', 'pipe'],
      cwd: PROJECT_PATH
    });

    const rl = createInterface({
      input: mcpProcess.stdout,
      crlfDelay: Infinity
    });

    let initialized = false;
    const requestId = `qwen-mcp-${Date.now()}`;

    rl.on('line', (line) => {
      try {
        const message = JSON.parse(line);

        if (message.id === 'init' && message.result) {
          initialized = true;
          // Отправляем запрос на инструмент
          const toolRequest = {
            jsonrpc: '2.0',
            id: requestId,
            method: 'tools/call',
            params: {
              name: toolName,
              arguments: args
            }
          };
          mcpProcess.stdin.write(JSON.stringify(toolRequest) + '\n');
        }

        if (message.id === requestId) {
          mcpProcess.kill();
          if (message.error) {
            reject(new Error(message.error.message));
          } else {
            resolve(message.result);
          }
        }
      } catch (err) {
        // Игнорируем ошибки парсинга
      }
    });

    mcpProcess.stderr.on('data', (data) => {
      console.error('MCP STDERR:', data.toString());
    });

    mcpProcess.on('close', (code) => {
      if (!initialized) {
        reject(new Error(`MCP process exited with code ${code} before initialization`));
      }
    });

    // Отправляем инициализацию
    const initRequest = {
      jsonrpc: '2.0',
      id: 'init',
      method: 'initialize',
      params: {
        protocolVersion: '2024-11-05',
        capabilities: {
          tools: {},
          resources: {}
        },
        clientInfo: {
          name: 'Qwen Code MCP Client',
          version: '1.0.0'
        }
      }
    };

    mcpProcess.stdin.write(JSON.stringify(initRequest) + '\n');

    // Таймаут на инициализацию
    setTimeout(() => {
      if (!initialized) {
        mcpProcess.kill();
        reject(new Error('MCP initialization timeout'));
      }
    }, 10000);
  });
}

/**
 * Чтение MCP ресурса
 * @param {string} uri - URI ресурса (например, 'unity://scenes_hierarchy')
 * @returns {Promise<object>} результат чтения
 */
export async function readMcpResource(uri) {
  return new Promise((resolve, reject) => {
    const mcpProcess = spawn('node', [MCP_UNITY_PATH], {
      stdio: ['pipe', 'pipe', 'pipe'],
      cwd: PROJECT_PATH
    });

    const rl = createInterface({
      input: mcpProcess.stdout,
      crlfDelay: Infinity
    });

    let initialized = false;
    const requestId = `qwen-mcp-res-${Date.now()}`;

    rl.on('line', (line) => {
      try {
        const message = JSON.parse(line);

        if (message.id === 'init' && message.result) {
          initialized = true;
          const resourceRequest = {
            jsonrpc: '2.0',
            id: requestId,
            method: 'resources/read',
            params: {
              uri: uri
            }
          };
          mcpProcess.stdin.write(JSON.stringify(resourceRequest) + '\n');
        }

        if (message.id === requestId) {
          mcpProcess.kill();
          if (message.error) {
            reject(new Error(message.error.message));
          } else {
            resolve(message.result);
          }
        }
      } catch (err) {
        // Игнорируем ошибки парсинга
      }
    });

    mcpProcess.stderr.on('data', (data) => {
      console.error('MCP STDERR:', data.toString());
    });

    mcpProcess.on('close', (code) => {
      if (!initialized) {
        reject(new Error(`MCP process exited with code ${code} before initialization`));
      }
    });

    const initRequest = {
      jsonrpc: '2.0',
      id: 'init',
      method: 'initialize',
      params: {
        protocolVersion: '2024-11-05',
        capabilities: {
          tools: {},
          resources: {}
        },
        clientInfo: {
          name: 'Qwen Code MCP Client',
          version: '1.0.0'
        }
      }
    };

    mcpProcess.stdin.write(JSON.stringify(initRequest) + '\n');

    setTimeout(() => {
      if (!initialized) {
        mcpProcess.kill();
        reject(new Error('MCP initialization timeout'));
      }
    }, 10000);
  });
}

// CLI режим для прямого вызова
if (import.meta.url === `file://${process.argv[1]}`) {
  const args = process.argv.slice(2);
  const toolName = args[0];
  
  if (!toolName) {
    console.log('MCP Unity Client v1.0');
    console.log('Использование:');
    console.log('  node mcp-client.js <tool_name> [args...]');
    console.log('  node mcp-client.js --resource <uri>');
    console.log('');
    console.log('Примеры:');
    console.log('  node mcp-client.js get_scene_info');
    console.log('  node mcp-client.js get_console_logs');
    console.log('  node mcp-client.js --resource unity://scenes_hierarchy');
    process.exit(0);
  }

  if (toolName === '--resource') {
    const uri = args[1];
    if (!uri) {
      console.error('Error: URI ресурса не указан');
      process.exit(1);
    }
    readMcpResource(uri)
      .then(result => {
        console.log(JSON.stringify(result, null, 2));
      })
      .catch(err => {
        console.error('Error:', err.message);
        process.exit(1);
      });
  } else {
    const toolArgs = args.slice(1).reduce((acc, arg, idx) => {
      if (arg.startsWith('--')) {
        const key = arg.slice(2);
        const value = args[idx + 1];
        if (value && !value.startsWith('--')) {
          acc[key] = isNaN(value) ? value : Number(value);
        } else {
          acc[key] = true;
        }
      }
      return acc;
    }, {});

    callMcpTool(toolName, toolArgs)
      .then(result => {
        console.log(JSON.stringify(result, null, 2));
      })
      .catch(err => {
        console.error('Error:', err.message);
        process.exit(1);
      });
  }
}
