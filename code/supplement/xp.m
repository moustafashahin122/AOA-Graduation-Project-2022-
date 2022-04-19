                if TF<.4
                    tfff='exploration'
                    plot(hhhh,m,'*')
                    axis([0 100 300 1200])
                    title(tfff)
                else
                    tfff='exploitation'
                    plot(hhhh,m,'*r')
                    axis([0 100 300 1200])
                    title(tfff)
                end
