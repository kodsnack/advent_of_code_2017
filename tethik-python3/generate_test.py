import os
import click
from jinja2 import Template

TEST_TEMPLATE = """
@test "{{name}}" {

input=$(cat << EOF
{{input}}
EOF
)

output=$(cat << EOF
{{output}}
EOF
)

result=$(echo "$input" | python {{script_name}})
[[ "$result" == "$output" ]]
}
"""

# @click.command()
# @click.option('--number', prompt='Challenge',
#               help='The challenge day to generate skeleton for.')
# def challenge(number):
#     filename = f'{number}.py'

#     click.echo(f'Created {filename}.')

def read_multiple_lines(prompt):
    lines = []
    print(prompt, '(multiline input)')
    while True:
        val = input().strip()
        if not val:
            break
        lines.append(val)
    return "\n".join(lines)


@click.command()
@click.option('--challenge', prompt='Challenge',
              help='The challenge day to generate skeleton for.')
def generate_tests(challenge):
    template = Template(TEST_TEMPLATE)

    dir_path = os.path.dirname(os.path.realpath(__file__))
    filename = f'{dir_path}/tests/{challenge}.bats'

    with open(filename, 'w+') as _file:
        args = {
            'script_name': f'{challenge}.py'
        }
        i = 0
        while True:
            i += 1
            args['name'] = f'{args["script_name"]} sample {i}'
            args['input'] = read_multiple_lines("Input: ")
            if not args['input']:
                break
            args['output'] = read_multiple_lines("Output: ").strip()
            _file.write(template.render(**args))
            _file.write('\n\n')
        i -= 1

    click.echo(f'{i} tests written to {filename}')

if __name__ == "__main__":
    generate_tests()
